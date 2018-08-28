class NetworkUsersController < ApplicationController
  def index
    @networks = current_user.networks
  end

  def show
    @network_user = NetworkUser.find(params[:id])
  end
end
