require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { FactoryBot.build(:user) }

  describe 'creation' do
    it 'can be created with valid attributes' do
      expect(user).to be_valid
    end

    it 'fails to create with invalid attributes' do
      user = User.new
      expect(user).to_not be_valid
    end
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:password) }
    it { should validate_uniqueness_of(:session_token)}

    it 'should validate presence of session_token and password_digest' do
      user = FactoryBot.create(:user)
      expect(user.session_token).to_not be_nil
      expect(user.password_digest).to_not be_nil
    end
  end

  describe 'class methods' do
    describe '::find_by_credentials' do
      let!(:user) { FactoryBot.create(:user, username: "username", password: "password") }

      context 'credentials are valid' do
        it 'returns a user object' do
          expect(User.find_by_credentials("username", "password")).to be_an_instance_of(User)
        end
        it 'returns the correct user' do
          valid_test = User.find_by_credentials("username", "password")
          expect(valid_test.username).to eq("username")
        end
      end

      context 'credentials are invalid' do
        it 'returns nil' do
          invalid_test = User.find_by_credentials("username", "wrong_pass")
          expect(invalid_test).to be_nil
        end
      end
    end
  end
end
