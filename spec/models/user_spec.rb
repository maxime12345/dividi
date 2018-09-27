require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to_not be_nil
  end

  before do
    @user_test = User.create(email: 'test@dividi.fr', password: '123456', password_confirmation: '123456')
  end

  it "own a token when created" do
    @user_test.valid?
    expect(@user_test.token).to_not be_nil
  end

  it "own a default collection when created" do
    expect(@user_test.collections[0].name).to eq 'All'
  end

  it "own a default network when created" do
    expect(@user_test.networks[0].name).to eq 'Tous'
  end
end
