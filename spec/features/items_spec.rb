require 'rails_helper'

RSpec.feature "Items", type: :feature do
  scenario "user add a new object", js: true do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:category)

    visit root_path

    fill_in "email", with: user.email
    fill_in "mot de passe", with: user.password
    find_button("Se connecter").click
    find_link('Ajouter un objet').click

    expect {

      fill_in "Nom", with: "Objet Test"
      select 'Autres', from: 'Catégorie'
      find('.collection_radio_buttons', match: :first).click

      find_button("Ajouter cet objet").click

      expect(page).to have_content 'Objet Test'

    }.to change(user.items, :count).by(1)
  end
end
