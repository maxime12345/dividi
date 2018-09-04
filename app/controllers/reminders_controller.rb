class RemindersController < ApplicationController
  def index
    @reminders_others = current_user.reminders_others
    @ghost_reminders = current_user.ghost_reminders
  end

  def new
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new(reminder_params)
    @reminder.item = @item
    if @reminder.save
      redirect_to collections_path
    else
      render :new
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    redirect_to collections_path
  end


  def new_outside
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new
  end

  def create_outside
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new(reminder_params)
    @reminder.item = @item

    if @reminder.save
      redirect_to collections_path
    else
      render :new_outside
    end
  end

  def new_item_outside
    @reminder = Reminder.new
  end

  def create_item_outside
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    if @reminder.save
      redirect_to collections_path
    else
      render :new_item_outside
    end

  end

  private

  def reminder_params
    params.require(:reminder).permit(:user_id, :ghost_name, :ghost_item)
  end
end
