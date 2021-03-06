# frozen_string_literal: true

class NetworkUsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_active_tab, only: :index

  def index
    skip_policy_scope

    # List of validate friends class by networks
    @default_network_users = current_user.default_network_users

    # List of validate friends to exclude from search
    @friends = current_user.friends

    # list of request sended by me
    @pending_network_users = current_user.pending_network_users

    # requests I recieve from others
    @friend_requests = current_user.friend_requests

    @default_network = current_user.default_network

    @users = User.all.reject { |user| current_user == user }
                 .select { |user| @friends.include?(user) == false }
                 .select { |user| @friend_requests.map(&:network).map(&:user).include?(user) == false }
                 .select { |user| @pending_network_users.map(&:user).include?(user) == false }

    if params[:query].present?
      @users = User.search_by_email_and_username(params[:query].to_s)
                   .reject { |user| current_user == user }
                   .select { |user| @friends.include?(user) == false }
                   .select { |user| @friend_requests.map(&:network).map(&:user).include?(user) == false }
                   .select { |user| @pending_network_users.map(&:user).include?(user) == false }
    end
    @network_user = NetworkUser.new
  end

  def create
    @network_user = NetworkUser.new(params_network_user)
    @network_user.network = Network.find(params[:network_id])
    @network_user.status = 'pending'
    authorize(@network_user)
    @network_user.save
    redirect_to network_users_path(tab: 'search')
  end

  def accept
    @network_user = NetworkUser.find(params[:id])
    @reverse_network_user = NetworkUser.new(user: @network_user.owner, network: current_user.default_network)
    authorize(@network_user)
    @network_user.status = nil
    @network_user.save
    @reverse_network_user.save
    redirect_to network_users_path
  end

  def destroy
    @network_user = NetworkUser.find(params[:id])
    authorize(@network_user)
    @network_user.destroy
    redirect_to network_users_path
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

  def set_active_tab
    @active_tab = params[:tab].in?(%w[amis question search]) ? params[:tab] : 'search'
  end
end
