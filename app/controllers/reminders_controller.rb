# frozen_string_literal: true

class RemindersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_active_tab, only: :index

  def index
    skip_policy_scope
    @reminders_others = current_user.reminders_others
    @ghost_reminders = current_user.ghost_reminders
    @my_reminders = current_user.my_reminders
    @validate_reminders = current_user.validate_reminders
    @waiting_reminders = current_user.waiting_reminders
    @reminder = Reminder.new
  end

  def new
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new
    authorize(@reminder)
  end

  def create
    @item = Item.find(params[:item_id])
    @reminders_to_destroy = @item.reminders.where(user_id: params[:reminder][:user_id])
    @reminders_to_destroy.each(&:destroy)
    @reminder = Reminder.new(reminder_params)
    authorize(@reminder)
    @reminder.item = @item
    if @reminder.user.nil?
      render :new
    elsif @reminder.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @item = @reminder.item
    authorize(@reminder)
    @reminder.destroy
    if !@reminder.ghost_item.nil?
      redirect_to reminders_path
    else
      redirect_to item_path(@item)
    end
  end

  def new_outside
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new
    authorize(@reminder)
  end

  def create_outside
    @item = Item.find(params[:item_id])
    @reminder = Reminder.new(reminder_params)
    @reminder.item = @item
    authorize(@reminder)
    if @reminder.ghost_name == ''
      redirect_to new_item_reminder_path(@item)
    elsif @reminder.save
      redirect_to item_path(@item)
    else
      render :new_outside
    end
  end

  def new_item_outside
    @reminder = Reminder.new
    authorize(@reminder)
  end

  def create_item_outside
    @reminder = Reminder.new(reminder_params)
    authorize(@reminder)
    @reminder.user = current_user

    @reminder.save unless @reminder.ghost_item == '' || @reminder.ghost_name == ''
    redirect_to reminders_path
  end

  def accept
    @reminder = Reminder.find(params[:id])
    authorize(@reminder)
    if @reminder.status == 'pending'
      @reminder.status = nil
      @reminder.save
    end
    redirect_back(fallback_location: reminders_path)
  end

  def decline
    @reminder = Reminder.find(params[:id])
    authorize(@reminder)
    @reminder.destroy
    redirect_back(fallback_location: reminders_path)
  end

  private

  def reminder_params
    params.require(:reminder).permit(:user_id, :ghost_name, :ghost_item, :status)
  end

  def set_active_tab
    @active_tab = params[:tab].in?(%w[emprunts demandes add]) ? params[:tab] : 'emprunts'
  end
end
