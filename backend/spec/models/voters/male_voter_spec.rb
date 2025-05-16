require 'rails_helper'

RSpec.describe Voters::MaleVoter, type: :model do
  let(:post) { create(:post) }
  let!(:male_votes)   { create_list(:vote, 4, post: post, gender: 1) }
  let!(:female_votes) { create_list(:vote, 2, post: post, gender: 2) }

  subject { described_class.new(post) }

  describe '#category' do
    it 'カテゴリーが :male_votes を返す' do
      expect(subject.category).to eq(:male_votes)
    end
  end

  describe '#vote_count' do
    it '男性votesのみカウントされる' do
      expect(subject.vote_count).to eq(4)
    end
  end
end
