# frozen_string_literal: true

class Item < ApplicationRecord
  searchkick

  Searchkick.search_timeout = 3

  belongs_to :collection
  belongs_to :category
  has_one :user, through: :collection
  has_many :reminders

  has_many :pending_reminders, -> { where(status: 'pending') }, class_name: 'Reminder'
  has_one :validate_reminder, -> { where(status: nil) }, class_name: 'Reminder'

  validates :name, presence: true
  validates :verbe, presence: true

  monetize :price_cents, disable_validation: true

  mount_uploader :photo, PhotoUploader

  def available?
    validate_reminder.nil?
  end

  def waiting_list?
    !pending_reminders.empty?
  end

  def waiting_answer?
    available? && waiting_list?
  end

  def loaned?
    validate_reminder && verbe == "To Lend"
  end

  def rented?
    validate_reminder && verbe == "To Rent"
  end

  def borrowable?
    verbe == 'To Lend' || verbe == 'To Rent'
  end

  def text(point_of_view)
    if point_of_view == 'out'
      case verbe
      when 'To Give' then 'Don'
      when 'To Sell' then "Vente: #{price_cents.fdiv(100).to_i}€"
      when 'To Lend' then 'Prêt'
      when 'To Rent' then "Location: #{price_cents.fdiv(100).to_i}€/jour"
      else
        verbe
      end
    else
      case verbe
      when 'To Lend' then 'Emprunté à:'
      when 'To Rent' then "Loué #{price_cents.fdiv(100).to_i}€/jour à:"
      else
        verbe
      end
    end
  end

  def my_object_description
    if available? && !waiting_list?
      'Disponible pour vos amis'
    elsif available? && waiting_list?
      'Vous avez une demande en attente de réponse'
    elsif loaned?
      "#{validate_reminder.user.username} vous l'a emprunté depuis le #{validate_reminder.created_at}"
    elsif rented?
      "#{validate_reminder.user.username} vous le loue depuis le #{validate_reminder.created_at}"
    end
  end

  def friend_object_description(current_user)
    if available? && !waiting_list?
      'Disponible'
    elsif available? && waiting_list?
      'Votre demande est en attente de réponse'
    elsif loaned? && validate_reminder.user.username == current_user.username
      "emprunté à #{user.username} depuis le #{validate_reminder.created_at}"
    elsif rented? && validate_reminder.user.username == current_user.username
      "loué à #{user.username} depuis le #{validate_reminder.created_at}"
    elsif loaned?
      "Déjà prêté"
    elsif rented?
      "Déjà loué"
    end
  end

  def object_description(current_user)
    if user == current_user
      my_object_description
    else
      friend_object_description(current_user)
    end
  end

  def self.to_give
    where(verbe: 'To Give')
  end

  def self.to_lend
    where(verbe: 'To Lend')
  end

  def self.verbes
    [['To Sell', I18n.t('items.new.sell')],
     ['To Give', I18n.t('items.new.give')],
     ['To Lend', I18n.t('items.new.lend')],
     ['To Rent', I18n.t('items.new.rent')]]
  end
end
