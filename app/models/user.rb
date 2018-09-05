class User < ApplicationRecord
  include PgSearch

  mount_uploader :avatar, PhotoUploader

  after_create :set_email_for_search
  before_create :token_creation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections
  has_many :items, through: :collections

  has_many :reminders_others, -> {where(ghost_item: nil)}, class_name: 'Reminder'
  has_many :ghost_reminders, -> {where(item_id: nil)}, class_name: 'Reminder'

  has_many :my_reminders, -> {where(status: nil)}, through: :items, source: :reminders
  # Reminders sur les objets qui m'appartiennent
  has_many :my_pending_reminders,-> {where(status: "pending")}, through: :items, source: :reminders

  has_many :networks
  has_many :network_users, through: :networks

  #rdefault network, name is Tous
  has_one :default_network, -> {where(name: "Tous")}, class_name: 'Network'

  has_many :pending_network_users, -> {where(status: "pending")}, through: :networks, source: :network_users
  has_many :validate_network_users, -> {where(status: nil)}, through: :networks, source: :network_users
  has_many :default_network_users, -> {where(status: nil)}, through: :default_network,  source: :network_users

  has_many :friends, through: :default_network_users, source: :user

  has_many :defaults_network_friends, through: :friends, source: :default_network

  has_many :shared_collections_friends, through: :defaults_network_friends, source: :shares

  has_many :collections_friends, through: :shared_collections_friends, source: :collection

  has_many :friends_items, through: :collections_friends, source: :items


  has_many :friend_requests, -> {where(status: "pending")}, class_name: 'NetworkUser'

  pg_search_scope :search_by_email_and_username,
    against: [ :email, :username, :email_for_search ],
    using: { tsearch: { prefix: true } }


  def label_method
    if username.nil?
      email
    else
      return "#{username}   -   #{email}"
    end
  end

  private

  # method avoid to use a bigger search gem, transform "bob.dylan@dividi.fr" in "bob dylan"
  def set_email_for_search
    self.email_for_search = self.email.split('@')[0].split('.').join(' ')

  end

  def token_creation
    self.token = SecureRandom.urlsafe_base64(nil, false)
  end

end
