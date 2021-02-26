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

  def job_itrerator(url, page, sum)
    list = []
    while page <= sum
      sub_unparsed_page = HTTParty.get(url + "&start=#{page}")
      sub_parsed_page = Nokogiri::HTML(sub_unparsed_page.body)
      sub_jobslist = sub_parsed_page.css('div.css-9hlx6w')
      sub_jobslist.each do |jobl|
        title = jobl.css('h2.css-m604qf')
        job = Job.new
        job.joblink = jobl.css('a.css-nn640c')[0].attributes['href'].value
        job.title = title.css('a.css-nn640c')[0].text
        job.location = jobl.css('span.css-5wys0k').text
        job.posttime = jobl.css('div.css-4c4ojb').text
        job.porf = jobl.css('span.css-1ve4b75.ex6kyvk0').text
        job.description = jobl.css('a.css-nn640c').text
        list.push(job)
      end
      page += 1
    end
    list
  end

  def job(url)
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    jobslist = parsed_page.css('div.css-9hlx6w')
    page = 1
    perpage = jobslist.count
    totaljobs = parsed_page.css('strong')[0].text
    totaljobs = totaljobs.delete(',')
    begin
      sum = (totaljobs.to_f / perpage).round
    rescue FloatDomainError
      return
    end
    job_itrerator(url, page, sum)
  end
end
