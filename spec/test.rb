require_relative '../lib/logic'

describe Logic do
  logic = Logic.new
  describe '#quote_validate_tags' do
    it 'it should return true or false' do
      expect(logic.quote_validate_tags('love')).to eql true
      expect(logic.quote_validate_tags('life')).to eql true
      expect(logic.quote_validate_tags('humor')).to eql true
      expect(logic.quote_validate_tags('test')).to eql false
      expect(logic.quote_validate_tags('something')).to eql false
    end
  end

  describe '#quote_url(tag)' do
    it 'it should return full url with key' do
      expect(logic.quote_url('love')).to eql 'https://quotes.toscrape.com/tag/love'
      expect(logic.quote_url('inspirational')).to eql 'https://quotes.toscrape.com/tag/inspirational'
      expect(logic.quote_url('life')).to eql 'https://quotes.toscrape.com/tag/life'
      expect(logic.quote_url('humor')).to eql 'https://quotes.toscrape.com/tag/humor'
      expect(logic.quote_url('books')).to eql 'https://quotes.toscrape.com/tag/books'
    end
  end

  describe '#quote' do
    it 'it should return Array' do
      a = logic.quote('https://quotes.toscrape.com/tag/inspirational')
      expect(a.class).to eql Array
    end
  end

end