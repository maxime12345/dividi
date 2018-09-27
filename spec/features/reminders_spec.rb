require 'rails_helper'

RSpec.feature "Reminders", type: :feature do
  before do
    @user = FactoryGirl.create(:user)

    visit root_path

    fill_in "email", with: @user.email
    fill_in "mot de passe", with: @user.password
    click_button "Se connecter"
    item = FactoryGirl.create(:item_to_rent_or_lend, collection: @user.collections[0])

    @friend = FactoryGirl.create(:user)
    NetworkUser.create(user: @friend, network: @user.networks[0])
    NetworkUser.create(user: @user, network: @friend.networks[0])

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
