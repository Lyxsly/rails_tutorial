require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user =User.new(name:"Example User",email:"user@example.com",password:"foobar",password_confirmation:"foobar")
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end
end
