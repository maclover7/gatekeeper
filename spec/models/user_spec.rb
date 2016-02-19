require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "#admin!" do
    it "changes a user to be an admin" do
      user = FactoryGirl.create(:user)
      user.admin!

      expect(user.admin).to eq(true)
    end
  end

  describe "#admin?" do
    it "returns/true false if a user is an admin" do
      user1 = FactoryGirl.create(:user)
      user1.admin!
      user2 = FactoryGirl.create(:user)

      expect(user1.admin?).to eq(true)
      expect(user2.admin?).to eq(false)
    end
  end
end
