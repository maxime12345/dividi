require 'rails_helper'

def connect
    @user = FactoryGirl.create(:user)

    visit root_path

    fill_in "email", with: @user.email
    fill_in "mot de passe", with: @user.password
    click_button "Se connecter"
end

def create_items_and_links
    @friend = FactoryGirl.create(:user)
    item = FactoryGirl.create(:item_to_rent_or_lend, collection: @user.collections[0])
    item_friend = FactoryGirl.create(:item_to_rent_or_lend, collection: @friend.collections[0])

    NetworkUser.create(user: @friend, network: @user.networks[0])
    NetworkUser.create(user: @user, network: @friend.networks[0])
end

RSpec.feature "Reminders as owner", type: :feature do
  before do
    connect

    create_items_and_links

    visit item_path(item)
    click_link "Déclarer"
  end

  scenario "Owner declares a lend an object to a friend in the network" do
    click_link "En dehors de mon réseau"
    select @friend.email, from: 'reminder_user_id'
    click_button "Prêter/Louer", match: :first
    expect(page).to have_content @friend.email
  end

  scenario "Owner declares a lend object to a friend NOT in the network" do
    click_link "En dehors de mon réseau"
    fill_in "Name", with: "Ami en test !"
    click_button "btn-outside-item"
    expect(page).to have_content "Ami en test !"
  end
end


RSpec.feature "Reminders as lender/borrower", type: :feature do
  before do
    @user = FactoryGirl.create(:user)
    @friend = FactoryGirl.create(:user)

    visit root_path

    fill_in "email", with: @user.email
    fill_in "mot de passe", with: @user.password
    click_button "Se connecter"
    item = FactoryGirl.create(:item_to_rent_or_lend, collection: @friend.collections[0])

    link1 = NetworkUser.create(user: @user, network: @friend.networks.where(name: "Tous")[0])
    link1reverse = NetworkUser.create(user: @friend, network: @user.networks.where(name: "Tous")[0])
  end

  scenario "I can send a request to a friend" do

  end

  scenario "I can delete my request to my friend" do

  end
end
