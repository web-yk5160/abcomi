require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:relationship) { user.active_relationships.build(followed_id: other_user.id) }

    it "relationshipが有効であること" do
      expect(relationship).to be_valid
    end

    it "follower_idがなければ無効な状態であること" do
      relationship.follower_id = nil
      expect(relationship).to be_invalid
    end

    it "followed_idがなければ無効な状態であること" do
      relationship.followed_id = nil
      expect(relationship).to be_invalid
    end
end
