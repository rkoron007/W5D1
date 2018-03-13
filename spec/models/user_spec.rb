require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_presence_of(:session_token)}

  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:goals)}
  it { should have_many(:comments)}

    describe "#reset_session_token!" do
      it "should reset session token" do
        user = User.create!(username:'apple', password:'apple6')
        session_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq(session_token)
      end
    end

    describe "::find_by_credentials" do
      context "with valid params" do
        it "should find a user" do
          user = User.create!(username:'apple', password:'apple6')
          apple = User.find_by_credentials('apple', 'apple6')
          expect(apple).to eq(user)
        end
      end

      context "with invalid params" do
        it "shouldn't find a user given the incorrect password" do
          user = User.create!(username:'apple', password:'apple6')
          not_apple = User.find_by_credentials('apple', 'apple5')
          expect(not_apple).to be_nil
        end

        it "should return nil if username is not found" do
          user = User.create!(username:'apple', password:'apple6')
          not_apple = User.find_by_credentials('', 'apple6')
          expect(not_apple).to be_nil
        end

        it "should return nil if username is not found" do
          not_apple = User.find_by_credentials('apple', 'apple6')
          expect(not_apple).to be_nil
        end
      end
    end

    describe "#password=" do
      context 'should not log the password in the database' do
        it "shouldn't save the input password" do
          user = User.create!(username:'apple', password:'apple6')
          expect(user.password_digest).not_to eq('apple6')
        end

        it "should call BCrypt" do
          user_params = { username: 'apple', password: 'apple6' }
          expect(BCrypt::Password).to receive(:create).with(user_params[:password])
          user = User.new(user_params)
        end
      end
    end

    describe "#is_password?(password)" do
      context "with valid params" do
        it "returns true for correct password" do
          user = User.new(username:'apple', password:'apple6')
          expect(user.is_password?('apple6')).to be true
        end
      end

      context "with valid params" do
        it "returns false for incorrect password" do
          user = User.new(username:'apple', password:'apple6')
          expect(user.is_password?('apple7')).to be false
        end
      end
    end


end
