# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home user_page]

  def home
    @user = User.new
  end

  def user_page
    @user = User.where(token: params[:token])[0]
    @collections = @user.collections
    @items = @user.items
    @url = url_for user_page_url(@user.token, locale: nil)
    @validate_reminders_number = @user.validate_reminders.size
    @friends_number = @user.friends.size
  end

  def dashboard; end

  def dashboard_admin
    @users = User.all
    @networks = Network.all
    @collections = Collection.all
    @shares = Share.all
    @network_users = NetworkUser.all
    @items = Item.all
    @reminders = Reminder.all
  end
end
