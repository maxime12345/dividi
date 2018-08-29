class NetworkUsersController < ApplicationController
  def index
    @networks = current_user.networks
    @all_users = User.all.select{ |user| current_user != user }
  end

  def show
    @network_user = NetworkUser.find(params[:id])
  end
end
