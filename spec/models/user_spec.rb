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
      expect(userOne.errors.messages[:email]).to include("has already been taken")
    end

    it 'should produce error if password is < 5 characters' do
      test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'pass', password_confirmation: 'pass')
      test_user.save
      expect(test_user.errors.messages[:password]).to include("is too short (minimum is 5 characters)")
    end

    describe '.authenticate_with_credentials'  do
      it 'should let user login' do
        test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
        test_user.save
        auth_user = User.authenticate_with_credentials('sakura@gmail.com', 'password')
        #  puts "#{auth_user.inspect}"
        expect(auth_user).to_not be_nil
      end

      it 'should not let user login with the wrong password' do
        test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
        test_user.save
        auth_user = User.authenticate_with_credentials('sakura@gmail.com', 'notpassword')
        #  puts "#{auth_user.inspect}"
        expect(auth_user).to be_nil
      end

      it 'should let users to log in with wrong case in email' do
        test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
        test_user.save
        auth_user = User.authenticate_with_credentials('Sakura@gmail.com', 'password')
        #  puts "#{auth_user.inspect}"
        expect(auth_user).to_not be_nil
      end

      it 'should let users to log in with white space in email' do
        test_user = User.new(name: 'Sakura', email: 'sakura@gmail.com', password: 'password', password_confirmation: 'password')
        test_user.save
        auth_user = User.authenticate_with_credentials(' sakura@gmail.com ', 'password')
        #  puts "#{auth_user.inspect}"
        expect(auth_user).to_not be_nil
      end
    end
  end
end