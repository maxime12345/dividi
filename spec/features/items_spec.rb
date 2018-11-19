# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Items', type: :feature do
  scenario 'user add a new object', js: true do
    user = FactoryBot.create(:user)
    FactoryBot.create(:category)

    visit user_session_path
    fill_in 'Courriel', with: user.email
    fill_in 'Mot de passe', with: user.password
    find_button('Connexion').click
    find('.shortcut', text: 'Ajouter un objet').click

    expect do
      fill_in 'Nom', with: 'Objet Test'
      select 'Autres', from: 'Catégorie'
      find('.collection_radio_buttons', match: :first).click

      find_button('Ajouter cet objet').click

      expect(page).to have_content 'Objet Test'
    end.to change(user.items, :count).by(1)
  end
end
