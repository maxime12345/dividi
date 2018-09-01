class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @items = Item.all
    @categories = @items.group(:category).count

    # cat=0,1,17&query=poeut&sort=name&verb=borrow,buy,sell,lease&owner=8
    # virgule separe les valeurs
    # si un champ est vide, il est considere comme non filtrant

    #Je créée une variable de session correspondant à l'id de la catégorie
    # params cat = "27,28" => session["cat"] = ["27","28"]
    params[:cat] = nil if params[:cat] == ""

    unless params[:cat] == nil
      session["cat"] = params[:cat].split(",") { |cat| cat.to_i }
    else
      session["cat"] = nil
    end

    p "sessioncat"
    p session["cat"]

    # session["cat"] = params[:cat].nil? ? nil : (params[:cat].split(",") { |cat| cat.to_i })
    session["sort"] = params[:sort]


    @items = @items.where(category: session["cat"]) unless session["cat"].nil?

    @items = @items.order(params[:sort]) if params[:sort] != ""
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

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :photo, :collection_id, :category_id, :verbe)
  end

end
