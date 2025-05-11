require 'rails_helper'

RSpec.describe Voters::NullVoter, type: :model do
  let(:post) { create(:post, gender: nil) }

  subject { described_class.new(post) }

  describe '#category' do
    it 'カテゴリーが :unknown を返す' do
      expect(subject.category).to eq(:unknown)
    end
  end

  describe '#vote_count' do
    it 'vote_countは常に0を返す' do
      expect(subject.vote_count).to eq(0)
    end
  end
end
