class NetworksController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!

  def add_somebody_in_network
    @network = Network.find(params[:id])
  end

  def update_somebody_in_network
    @network = Network.find(params[:id])
    @network_user = NetworkUser.new(user_id: params[:network][:network_users], network: @network)
    raise
    if @network_user.save
      redirect_to network_users_path
    else
      render :add_somebody_in_network
    end
  end
end
