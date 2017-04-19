require 'rss'

class RssReader
  def initialize(link)
    @reader = RSS::Parser.parse(open(link))
  end

  def channel_data
    feed = @reader.channel

    {
      title:           feed.title,
      description:     feed.description,
      language:        feed.language,
      pub_date:        feed.pubDate,
      last_build_date: feed.lastBuildDate
    }
  end

  def article_data
    @reader.items.map do |article|
      {
        title:        article.title,
        description:  article.description.partition('<').first,
        link:         article.link
      }
    end
  end
end
