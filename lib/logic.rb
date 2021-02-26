require_relative '../lib/settings'

require 'httparty'
require 'nokogiri'

class Logic
  def quote_validate_tags(tag)
    tags = %w[love inspirational life humor books reading friendship friends truth simile]
    tags.each do |q|
      return true if q == tag
    end
    false
  end

  def quote_url(tag)
    basic_url = 'https://quotes.toscrape.com/'
    "#{basic_url}tag/#{tag}"
  end

  def quote(url)
    unparsed_page = HTTParty.get(url)
    parse_page = Nokogiri::HTML(unparsed_page.body)
    quotes = parse_page.css('div.quote')
    arr = []
    quotes.each do |quote|
      quotes = Quotes.new
      quotes.text = quote.css('span.text').text
      quotes.author = quote.css('small.author').text
      quotes.tags = quote.css('meta.keywords')[0].attributes['content'].value
      arr.push(quotes)
    end
    arr
  end

  def job_url(sub_url)
    basic_url = 'https://wuzzuf.net/search/jobs/?q='
    basic_url + sub_url
  end
end
