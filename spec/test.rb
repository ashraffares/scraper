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

end