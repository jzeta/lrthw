class Lexicon
  Pair = Struct.new(:token, :word)

  def initialize()
    @guide = {  :direction => ["north", "south", "east", "west", "down", "up", "left", "right", "back"],
                :verb => ["go", "stop", "kill", "eat"],
                :stop => ["the", "in", "of", "from", "at", "it"],
                :noun => ["door", "bear", "princess", "cabinet"],
              }  
  end

  def scan(input_string)
    words = input_string.split()
    word_list = []
    words.each do |input_word|
      new_token, new_word = '', ''
      @guide.each do |token, token_values|
        if token_values.include? input_word
          new_token, new_word = token, input_word
        elsif convert_number(input_word) != nil
          new_token, new_word = :number, convert_number(input_word)
        end
      end
      new_token, new_word = :error, input_word unless new_token != ''
      word_list << Pair.new(new_token, new_word)
    end
    word_list
  end

  def convert_number(s)
    begin
      Integer(s)
    rescue ArgumentError
      nil
    end
  end
end