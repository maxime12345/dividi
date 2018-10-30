# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  it '#home responds successfully' do
    get :home
    expect(response).to be_successful
  end

  it '#user_page (ma page) responds successfully' do
    user = FactoryBot.create(:user)
    get :user_page, params: { token: user.token }
    expect(response).to be_successful
  end
end
