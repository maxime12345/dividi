# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @user.confirm
    sign_in @user
  end

  it '#index (Tous les objets) responds successfully' do
    get :index
    expect(response).to be_successful
  end

  it '#create allows to create an item' do
    item = FactoryBot.attributes_for(:item_to_rent_or_lend, collection: @user.collections[0])
    get :create, params: { item: item }
    expect(response).to be_successful
  end
end
