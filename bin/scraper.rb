require_relative '../lib/logic'
require 'colorize'
class Main < Logic
    def quote_scrape
        puts
        puts 'tags example: love - inspirational - life - humor - books - reading - friendship - friends - truth - simile'
        puts 'Enter quote tag: '
        tag = gets.chomp
        unless quote_validate_tags(tag)
          puts 'WRONG INPUTS TRAY AGAIN.'.red
          quote_scrape
        end
        url = quote_url(tag)
        quote(url).each do |q|
          puts "#{q.text} |  #{q.author} | #{q.tags}"
          puts '________________________________________________________________________________________________________________________'
        end
      end
end