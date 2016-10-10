require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryGirl.build(:user)
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6).on(:create) }

  it { should have_many(:goals) }

  context ".find_by_credentials" do
    before { user.save }
    
    it "return user for valid credentials" do
      expect(User.find_by_credentials("Todd", "asdfasdf")).to eq(user)
    end

    it "return nil for invalid credentials" do
      expect(User.find_by_credentials("Todd", "asdfasdff")).to be_nil
    end
  end
end
