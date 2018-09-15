# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  username         :string           not null
#  remaining_cheers :integer          not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  it {should validate_presence_of (:username)}
  it {should validate_presence_of (:remaining_cheers)}
  it {should validate_presence_of (:password_digest)}
  it {should validate_length_of(:password).is_at_least(6)} 
  
  describe " #password=" do
    it "sets the instance variable password" do
      user = FactoryBot.build(:user)
      expect(user.password=("abcdef")).to eq("abcdef")
    end
    
    it "encrypts password and assigns to password_digest" do
      user = FactoryBot.build(:user)
      user.password=("abcdef")
      expect(user.password_digest).not_to eq("abcdef")
    end
    
  end
  
  
  
  describe "User::find_by_credentials" do
    it "should find by username first" do 
      user = FactoryBot.create(:user,password: "111111")
      # user = User.new(username: "john", password: "1111111",
      #   session_token: "abc123", remaining_cheers: 12)
      #  user.save!
        expect( User.find_by_credentials('john',"111111") ).to be_an_instance_of(User)
    end

  
    it "returns nil if credentials are bad" do
      user = FactoryBot.create(:user,password: "245690")
      expect( User.find_by_credentials('john',"111111") ).to eq(nil)

    end
  
    it "returns user if credentials are good" do
      user = FactoryBot.create(:user,password: "111111")
      expect( User.find_by_credentials('john',"111111") ).to eq(user)
    end
    
  end
  
  describe "#reset_session_token!" do
    it 'should generate a new session token and assign it to the user' do
      user = FactoryBot.create(:user,password: "245690", session_token: "abcde")
      expect(user.reset_session_token!).not_to eq("abcde")
    end
    
    it "saves the session token into the database and returns the token" do
      user = FactoryBot.create(:user,password: "245690", session_token: "abcde")
      session = user.reset_session_token!
      user2 = User.find_by(username: "john")
      expect(user2.session_token).to eq(session)
    end
    
  end
  
end
