class ItemsController < ApplicationController
  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
  end
end
