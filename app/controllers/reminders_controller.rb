class RemindersController < ApplicationController
  def index
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

  private

  def reminder_params
    params.require(:reminder).permit(:user_id)
  end
end
