class PagesController < ApplicationController
  def home
    @user = User.new
  end

  def user_page
    @user = User.where(token: params[:token])[0]
    @collections = current_user.collections
  end
end
