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
end
