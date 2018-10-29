# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @on_items_page = true

    @where = {}
    @order = {}
    @query = '*'
    @params_categories = []
    @params_sort = []

    # Filter items by category if categories are present in params
    if params[:cat].present?
      @where = { category_id: params[:cat] }
      @params_categories = params[:cat]
    end
    if params[:sort].present?
      @order = { name: params[:sort] }
      @params_sort = params[:sort]
    end
    @query = params[:query] if params[:query].present?

    @scope_items = policy_scope(Item)

    @items = Item.search(@query, where: @where, order: @order, scope_results: ->(r) { r.where(id: @scope_items.pluck(:id)) })

    # We only take categories of @items
    # User.all.map(&:email) => return an array of user's email
    @categories = Category.all.select { |category| current_user.friends_items.map(&:category).include?(category) == true }
  end

  def show
    authorize(@item)
    @verbe = @item.verbe
  end

  def new
    @item = Item.new
    authorize(@item)
  end

  # POST /collections/:collection_id/items
  def create
    @item = Item.new(item_params)
    authorize(@item)
    @item.collection = current_user.default_collection
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    authorize(@item)
  end

  def update
    authorize(@item)
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def destroy
    authorize(@item)
    @item.reminders.destroy_all
    @item.destroy
    redirect_to collections_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :photo, :collection_id, :category_id, :verbe, :description)
  end
end
