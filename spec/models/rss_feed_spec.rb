require 'rails_helper'

RSpec.describe RssFeed, type: :model do
  subject{build :rss_feed}

  describe 'sanity check' do
    it{expect(subject).to be_valid}

    let(:no_title){build(:rss_feed, :no_title)}
    it 'must have a title' do
      expect(no_title).to be_invalid
    end

    let(:no_link){build(:rss_feed, :no_link)}
    it 'must have a link' do
      expect(no_link).to be_invalid
    end

    let(:no_description){build(:rss_feed, :no_description)}
    it 'must have a description' do
      expect(no_description).to be_invalid
    end
  end

  describe '#scrape_articles' do
    it 'should enqueue a worker' do
      subject.save

      VCR.use_cassette('rss_feed') do
        subject.scrape_articles
      end

      expect(enqueued_jobs.size).to eq 1
    end
  end
end
