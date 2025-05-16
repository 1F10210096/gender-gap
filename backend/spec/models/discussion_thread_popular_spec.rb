require 'rails_helper'

RSpec.describe DiscussionThreadPopular, type: :model do
  let(:thread1) { create(:discussion_thread) }
  let(:thread2) { create(:discussion_thread) }

  let(:query) do
    double('DiscussionThreadQuery', popular: [thread1, thread2])
  end

  let(:summarizer) do
    Class.new do
      def self.call(thread:)
        { id: thread.id, dummy: true }
      end
    end
  end

  before do
    Rails.cache.clear
  end

  describe '.call' do
    it 'popularスレッドのsummaryを返す' do
      result = described_class.call(query: query, summarizer: summarizer)

      expect(result).to be_an(Array)
      expect(result.size).to eq(2)
      expect(result.first).to include(:id, :dummy)
    end
  end
end
