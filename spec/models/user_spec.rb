require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should save each field successfully' do
      test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
      expect(test_user).to be_valid
    end

    it 'should produce error without name' do
      test_user = User.new(name: nil, email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
      test_user.save
      expect(test_user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should produce error without email' do
      test_user = User.new(name: 'Sakura', email: nil, password: 'password', password_confirmation: 'password')
      test_user.save
      expect(test_user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should produce error without password' do
      test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: nil, password_confirmation: 'password')
      test_user.save
      expect(test_user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should produce error without password confirmation' do
      test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: nil)
      test_user.save
      expect(test_user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should produce error if password does not match password confirmation' do
      test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'notpassword')
      test_user.save
      expect(test_user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should produce error if email already exist' do
      test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
      test_user.save
      userOne = User.new(name: 'Itachi', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
      userOne.save
      expect(test_user.errors.messages).to include("email already exist")
    end

    describe '.authenticate_with_credentials'  do
    end
  end
end