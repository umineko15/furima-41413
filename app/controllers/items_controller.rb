class ItemsController < ApplicationController
  def index
  end

  def new
    @Item = Item.new
  end
end
