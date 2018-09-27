require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  it "#index (Tous les objets) responds successfully" do
    user = FactoryGirl.create(:user)
    user.confirm
    sign_in user
    get :index
    expect(response).to be_successful
  end
end
