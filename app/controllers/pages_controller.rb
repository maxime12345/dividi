class PagesController < ApplicationController
  def home
    @user = User.new
  end

  def user_page
    @user = User.where(token: params[:token])[0]
    @collections = @user.collections
    @items = @user.items
  end

  def dashboard
    @users = User.all
    @networks = Network.all
    @collections = Collection.all
    @shares = Share.all
    @network_users = NetworkUser.all
    @items = Item.all
    @reminders = Reminder.all
  end
end
