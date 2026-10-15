class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]

    if @item.user == current_user
      redirect_to root_path
      return
    end

    if @item.order.present?
      redirect_to root_path
      return
    end

    @order = Order.new
    @address = Address.new
  end


def create
  gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  @item = Item.find(params[:item_id])

  if @item.user == current_user || @item.order.present?
    redirect_to root_path
    return
  end

  @order = Order.new(order_params)
  @order.token = params[:token]
  @address = Address.new(address_params)
  @address.order = @order

  # 注文と配送先の両方を検証する
  order_valid = @order.valid?
  address_valid = @address.valid?

  unless order_valid && address_valid
    render :index, status: :unprocessable_entity
    return
  end

  begin
    pay_item

    ActiveRecord::Base.transaction do
      @order.save!
      @address.save!
    end

    redirect_to root_path

  rescue ActiveRecord::RecordInvalid
    render :index, status: :unprocessable_entity

  rescue Payjp::PayjpError => e
    Rails.logger.error("PAY.JP payment failed: #{e.class}")
    @order.errors.add(:base, "決済に失敗しました。カード情報をご確認ください")
    render :index, status: :unprocessable_entity
  end
end

 private

  def order_params
    {
      user_id: current_user.id,
      item_id: params[:item_id]
    }
  end

  def address_params
    params.require(:order).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building_name,
      :phone_number
    )
  end

  def pay_item
    Payjp.api_key = ENV.fetch("PAYJP_SECRET_KEY")

    Payjp::Charge.create(
      amount: @item.price,
      card: @order.token,
      currency: "jpy"
    )
  end
end
