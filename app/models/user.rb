class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections
  has_many :items, through: :collections

  has_many :reminders_others, class_name: 'Reminder'

  has_many :my_reminders, through: :items, source: :reminders
end
