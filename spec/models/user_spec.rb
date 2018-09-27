require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to_not be_nil
  end
  it "own a token when created" do
    user_test = User.create(email: 'test@dividi.fr', password: '123456', password_confirmation: '123456')
    user_test.valid?
    expect(user_test.token).to_not be_nil
  end
end
