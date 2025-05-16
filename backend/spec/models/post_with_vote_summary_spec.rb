require 'rails_helper'

RSpec.describe PostWithVoteSummary, type: :model do
  let(:thread) { create(:discussion_thread) }
  let!(:post1) { create(:post, discussion_thread: thread, gender: 1) } # 男性post
  let!(:post2) { create(:post, discussion_thread: thread, gender: 2) } # 女性post
  let!(:male_votes_post1) { create_list(:vote, 2, post: post1, gender: 1) }
  let!(:female_votes_post2) { create_list(:vote, 3, post: post2, gender: 2) }

  describe '.call' do
    it 'スレッドの投票サマリーを正しく返す' do
      summary = described_class.call(thread: thread)

      expect(summary[:id]).to eq(thread.id)
      expect(summary[:thread_title]).to eq(thread.thread_title)
      expect(summary[:comments_count]).to eq(thread.posts.count)
      expect(summary[:votes_summary][:male_votes]).to eq(2)
      expect(summary[:votes_summary][:female_votes]).to eq(3)
    end
  end
end