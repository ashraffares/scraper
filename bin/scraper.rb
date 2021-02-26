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

      def job_scrape
        puts 'Search jobs: '
        sub_url = gets.chomp
        url = job_url(sub_url)
        begin
          job(url).each_with_index do |q, index|
            puts index
            puts q.joblink.to_s
            puts '---------------------------------------------------------------------------------------------'
            puts "#{q.title} |  #{q.location} | #{q.porf} | #{q.posttime}"
            puts '--------------------------------------------------------------------------------------------'
            puts "#{q.description} "
            puts '________________________________________________________________________________________________________________________'
          end
        rescue NoMethodError
          puts 'invalid inputs try again'.red
          nil
        end
      end

      def ask_user
        puts
        puts 'Type y to continue or Enter to end'
        var = gets.chomp
        return true if var == 'y'
    
        puts 'Program Ended'.green
      end
end