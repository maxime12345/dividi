class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @items = Item.all
    @collections = current_user.collections

    unless session["query"]
      session["query"]=""
      session["col"]=0
      session["order"]=""
    end

    session["query"] = params[:query] if params[:query]
    session["col"] = params[:col].to_i if params[:col]
    session["order"] = params[:order] if params[:order]

    @items = Item.search_by_name("#{session["query"]}") if session["query"] != ""
    @items = @items.where(collection: session["col"]) if session["col"] != 0
    @items = @items.order(session["order"]) if session["order"] != ""

  end

  def show
    if @item.verbe == "to_sell"
      @text = "To sell"
    elsif @item.verbe == "to_rent"
      @text = "To rent"
    elsif @item.verbe == "to_give"
      @text  = "To give"
    elsif @item.verbe == "to_lend"
      @text = "To lend"
    else
      @text = @item.verbe
    end
  end

  def new
    @item = Item.new
  end

  # POST /collections/:collection_id/items
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to collections_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :photo, :collection_id, :category_id, :verbe)
  end

end
