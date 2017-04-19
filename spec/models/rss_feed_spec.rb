require 'rails_helper'

RSpec.describe RssFeed, type: :model do
  subject{build :rss_feed}

  before :all do
    VCR.use_cassette('rss_feed') do
      # subject.
    end
  end

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
end
