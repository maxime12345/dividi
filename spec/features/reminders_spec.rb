# frozen_string_literal: true

require 'rails_helper'

def connect
  @user = FactoryBot.create(:user)

  visit root_path

  fill_in 'email', with: @user.email
  fill_in 'mot de passe', with: @user.password
  click_button 'Se connecter'
end

def add_friend
  @friend = FactoryBot.create(:user)
  NetworkUser.create(user: @friend, network: @user.networks[0])
  NetworkUser.create(user: @user, network: @friend.networks[0])
end

def create_items
  category = FactoryBot.create(:category)
  @item = FactoryBot.create(:item_to_rent_or_lend, collection: @user.collections[0], category: category)
  @item_friend = FactoryBot.create(:item_to_rent_or_lend, collection: @friend.collections[0], category: category)
end

def before
  connect
  add_friend
  create_items
end

RSpec.feature 'Reminders', type: :feature do
  before { before }

  context 'As a owner' do
    before do
      visit item_path(@item, locale: I18n.locale)
      click_link 'Déclarer'
    end

    scenario 'I can declare an object to lend to a friend in the network' do
      click_link 'En dehors de mon réseau'
      select @friend.email, from: 'reminder_user_id'
      click_button 'Prêter/Louer', match: :first
      expect(page).to have_content @friend.email
    end

    scenario 'I can declare an object to lend to a friend NOT in the network' do
      click_link 'En dehors de mon réseau'
      fill_in 'Name', with: 'Ami en test !'
      click_button 'btn-outside-item'
      expect(page).to have_content 'Ami en test !'
    end
  end

  context 'As a lender/borrower' do
    before { visit item_path(@item_friend, locale: I18n.locale) }

    scenario 'I can send a request to a friend' do
      click_link 'Envoyer une notification'
      expect(page).to have_content 'Annuler ma notification'
    end

    scenario 'I can delete my request to my friend' do
      click_link 'Envoyer une notification'
      click_link 'Annuler ma notification'
      expect(page).to have_content 'Envoyer une notification'
    end
  end
end
