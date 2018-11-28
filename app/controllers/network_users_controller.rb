# frozen_string_literal: true

class NetworkUsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!

  def index
    # List of validate friends
    @default_network_users = policy_scope(NetworkUser)
    @friends = current_user.friends
  end

  def search
    skip_policy_scope

    # List of validate friends to exclude from search
    @friends = current_user.friends
    if params[:query].present?
      return @users = User.search_by_email_and_username(params[:query].to_s)
                          .reject { |user| current_user == user }
                          .select { |user| @friends.include?(user) == false }
    else
      return @users = User.all.reject { |user| current_user == user }
                          .select { |user| @friends.include?(user) == false }
    end
  end

  def create
    params[:network_user] = {} # Allow to pass through permission
    params[:network_user][:user_id] = params[:user]
    params[:network_user][:network_id] = params[:network_id]
    @network_user = NetworkUser.new(params_network_user)
    @network_user.status = 'pending'
    authorize(@network_user)
    @network_user.save
    redirect_to search_network_users_path
  end

  def accept
    @network_user = NetworkUser.find(params[:id])
    @reverse_network_user = NetworkUser.new(user: @network_user.owner, network: current_user.default_network)
    authorize(@network_user)
    @network_user.status = nil
    @network_user.save
    @reverse_network_user.save
    redirect_to search_network_users_path
  end

  def destroy
    @network_user = NetworkUser.find(params[:id])
    authorize(@network_user)
    @network_user.destroy
    redirect_to search_network_users_path
  end

  def destroy_all_links
    @network_user = NetworkUser.find(params[:id])
    authorize(@network_user)
    # select all network_users with the same user
    @network_users_to_delete = current_user.network_users.where(user: @network_user.user)

    # select reverse network_users
    @reverse_network_users_to_delete = @network_user.user.network_users.where(user: current_user)

    # delete all links between 2 people
    @network_users_to_delete.each(&:destroy)
    @reverse_network_users_to_delete.each(&:destroy)
    redirect_to network_users_path
  end

  private

  def params_network_user
    params.require(:network_user).permit(:user_id, :network_id)
  end
end
