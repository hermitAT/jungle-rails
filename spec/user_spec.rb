require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save for a new user with all validations present' do
      @user = User.new({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })
      @user.save!

      expect(@user.id).to be_present
    end

    it 'should not be valid without a first name' do
      @user = User.create({ last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it 'should not be valid without a last name' do
      @user = User.create({ first_name: 'John', email: 'john@example.com', password: 'password', password_confirmation: 'password' })
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it 'should not be valid without an email' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password' })
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it 'should not be valid without a password' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password_confirmation: 'password' })
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    
    it 'should not be valid with a password shorter than 6 characters' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'hi', password_confirmation: 'hi' })
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end

    it 'should not be valid without a password confirmation' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password' })
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["Password confirmation can't be blank"]
    end

    it 'should not be valid if password confirmation does not match password' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'passwor'})
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with a valid email and password' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })

      expect(@user.authenticate_with_credentials('john@example.com', 'password')).to eq @user
    end
    
    it 'should not authenticate if the password does not match' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })

      expect(@user.authenticate_with_credentials('john@example.com', 'passwor')).to eq nil
    end

    it 'should not authenticate if the email is not found' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })

      expect(@user.authenticate_with_credentials('john@example.ca', 'password')).to eq nil
    end

    it 'should authenticate even if whitespace surrounds the email' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })

      expect(@user.authenticate_with_credentials('  john@example.com  ', 'password')).to eq @user
    end

    it 'should authenticate even if case does not match for the email' do
      @user = User.create({ first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' })

      expect(@user.authenticate_with_credentials('jOHN@examPLE.com', 'password')).to eq @user
    end

  end
end
