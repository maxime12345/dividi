# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectionsController, type: :controller do
  it '#index (mes objets) responds successfully' do
    user = FactoryGirl.build(:user)
    user.confirm
    sign_in user
    get :index
    expect(response).to be_successful
  end
end
