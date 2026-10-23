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

    @order_address = OrderAddress.new
  end


  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])

    if @item.user == current_user || @item.order.present?
      redirect_to root_path
      return
    end

    @order_address = OrderAddress.new(order_address_params)
    @order_address.user_id = current_user.id
    @order_address.item_id = @item.id
    @order_address.token = params[:token]

    # 入力内容を検証する
    unless @order_address.valid?
      render :index, status: :unprocessable_entity
      return
    end

    begin
      # PAY.JPで決済する
      pay_item

      # 注文と配送先を保存する
    unless @order_address.save
      render :index, status: :unprocessable_entity
      return
    end

    redirect_to root_path

    rescue ActiveRecord::RecordInvalid
      render :index, status: :unprocessable_entity

    rescue Payjp::PayjpError => e
      Rails.logger.error("PAY.JP payment failed: #{e.class}")
      @order_address.errors.add(
        :base,
        "決済に失敗しました。カード情報をご確認ください"
      )
      render :index, status: :unprocessable_entity
    end
  end
end

private

def order_address_params
  params.require(:order_address).permit(
    :postal_code,
    :prefecture_id,
    :city,
    :address,
    :building_name,
    :phone_number
  )
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp::Charge.create(
    amount: @item.price,
    card: @order_address.token,
    currency: "jpy"
  )
end
