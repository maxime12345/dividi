# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NetworkUsersController, type: :controller do
  it '#index (Mes amis) responds successfully' do
    user = FactoryBot.build(:user)
    user.confirm
    sign_in user
    get :index
    expect(response).to be_successful
  end
end
