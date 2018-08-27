class RemindersController < ApplicationController
  def index
    @reminders_others = current_user.reminders_others
    @my_reminders = current_user.my_reminders
  end
end
