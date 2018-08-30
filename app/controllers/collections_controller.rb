class CollectionsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @collections = current_user.collections
    @reminders_others = current_user.reminders_others
  end

  private

end
