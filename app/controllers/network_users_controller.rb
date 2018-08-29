class NetworkUsersController < ApplicationController
  def index
    @networks = current_user.networks
    @friends = current_user.friends

    @users = User.all.select{ |user| current_user != user }.select{ |user| @friends.include?(user) == false }

    if params[:query].present?
      @users = User.search_by_email_and_username("#{params[:query]}").select{ |user| current_user != user }.select{ |user| @friends.include?(user) == false }
    end
  end

  def show
    @network_user = NetworkUser.find(params[:id])
  end
end
