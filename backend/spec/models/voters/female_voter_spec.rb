require 'rails_helper'

RSpec.describe Voters::FemaleVoter, type: :model do
  let(:post) { create(:post) }
  let!(:female_votes) { create_list(:vote, 3, post: post, gender: 2) }
  let!(:male_votes)   { create_list(:vote, 2, post: post, gender: 1) }

  subject { described_class.new(post) }

  describe '#category' do
    it 'カテゴリーが :female_votes を返す' do
      expect(subject.category).to eq(:female_votes)
    end
  end

  describe '#vote_count' do
    it '女性votesのみカウントされる' do
      expect(subject.vote_count).to eq(3)
    end
  end
end