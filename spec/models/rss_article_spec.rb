require 'rails_helper'

RSpec.describe RssArticle, type: :model do
  before :all do
    RssFeed.skip_callback(:create, :around, :process_rss_feed)
  end

  after :all do
    RssFeed.set_callback(:create, :around, :process_rss_feed)
  end

  subject{build :rss_article}

  describe 'sanity check' do
    it{expect(subject).to be_valid}

    let(:no_title){build(:rss_article, :no_title)}
    it 'must have a title' do
      expect(no_title).to be_invalid
    end

    let(:no_link){build(:rss_article, :no_link)}
    it 'must have a link' do
      expect(no_link).to be_invalid
    end

    let(:no_description){build(:rss_article, :no_description)}
    it 'must have a description' do
      expect(no_description).to be_invalid
    end

    let(:no_rss_feed){build(:rss_article, :no_rss_feed)}
    it 'must have a rss feed' do
      expect(no_rss_feed).to be_invalid
    end
  end
end
