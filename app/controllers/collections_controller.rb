# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[edit update destroy]
  before_action :set_active_tab, only: :index

  protect_from_forgery
  before_action :authenticate_user!

  def index
    @collection = Collection.new
    @item = Item.new
    @collections = policy_scope(Collection)
    @my_pending_reminders = current_user.my_pending_reminders
  end

  def create
    @collection = Collection.new(params_collection)
    @collection.user = current_user
    authorize(@collection)
    @collection.save
    @share = Share.create(network: current_user.default_network, collection: @collection)
    @share.save
    redirect_to collections_path
  end

  def edit
    authorize(@collection)
  end

  def update
    @collection.update(params_collection)
    authorize(@collection)
    if @collection.save
      redirect_to collections_path
    else
      render :edit
    end
  end

  def destroy
    @share = Share.where(collection: @collection)[0]
    @share.destroy
    authorize(@collection)
    @collection.destroy
    redirect_to collections_path
  end

  private

  def params_collection
    params.require(:collection).permit(:name)
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def set_active_tab
    @active_tab = params[:tab].in?(%w[available question not-available add]) ? params[:tab] : 'available'
  end
end
