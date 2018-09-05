class CollectionsController < ApplicationController
  before_action :set_collection, only: [:edit, :update, :destroy]
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @collection = Collection.new
    @collections = current_user.collections
  end

  def create
    @collection = Collection.new(params_collection)
    @collection.user = current_user
    @collection.save
    @share = Share.create(network: current_user.default_network, collection: @collection)
    @share.save
    redirect_to collections_path
  end

  def edit

  end

  def update

    @collection.update(params_collection)
    if @collection.save
      redirect_to collections_path
    else
      render :edit
    end
  end

  def destroy
    @share = Share.where(collection: @collection)[0]
    @share.destroy
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

end
