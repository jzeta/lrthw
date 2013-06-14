require 'test/unit'
require_relative '../lib/ex49'
require_relative '../lib/lexicon'

class ParserTests < Test::Unit::TestCase

  Pair = Lexicon::Pair
  @@lexicon = Lexicon.new()

  def test_parse_verb()
    assert_equal(Pair.new(:verb, "kill"), Parser.parse_verb([Pair.new(:verb, "kill")]))
    assert_equal(Pair.new(:verb, "kill"), Parser.parse_verb([Pair.new(:stop, "the"),
                                                              Pair.new(:verb, "kill")]))
    assert_raise ParserError do
      Parser.parse_verb([Pair.new(:noun, "princess")])
    end
    assert_raise ParserError do
      Parser.parse_verb([Pair.new(:direction, "east")])
    end
  end

  def test_parse_object()
    assert_equal(Pair.new(:noun, "bear"), Parser.parse_object([Pair.new(:noun, "bear")]))
    assert_equal(Pair.new(:noun, "bear"), Parser.parse_object([Pair.new(:stop, "the"),
                                                                Pair.new(:noun, "bear")]))
    assert_equal(Pair.new(:direction, "north"), Parser.parse_object([Pair.new(:direction,"north")]))
    assert_equal(Pair.new(:direction, "north"), Parser.parse_object([Pair.new(:stop, "from"),
                                                                      Pair.new(:direction, "north")]))
    assert_raise ParserError do
      Parser.parse_object([Pair.new(:verb, "go")])
    end
  end

  def test_parse_sentence()
    sentence = Parser.parse_sentence([Pair.new(:verb, "open"),
                                      Pair.new(:stop, "the"),
                                      Pair.new(:noun, "door")])
    assert_equal("player", sentence.subject)
    assert_equal("open", sentence.verb)
    assert_equal("door", sentence.object)

    sentence = Parser.parse_sentence([Pair.new(:stop, "in"),
                                      Pair.new(:verb, "open"),
                                      Pair.new(:stop, "the"),
                                      Pair.new(:noun, "door")])
    assert_equal("player", sentence.subject)
    assert_equal("open", sentence.verb)
    assert_equal("door", sentence.object)

    sentence = Parser.parse_sentence([Pair.new(:noun, "princess"),
                                          Pair.new(:verb, "open"),
                                          Pair.new(:stop, "the"),
                                          Pair.new(:noun, "door")])
    assert_equal("princess", sentence.subject)
    assert_equal("open", sentence.verb)
    assert_equal("door", sentence.object)

    sentence = Parser.parse_sentence([Pair.new(:verb, "go"),
                                      Pair.new(:direction, "north")])
    assert_equal("player", sentence.subject)
    assert_equal("go", sentence.verb)
    assert_equal("north", sentence.object)
                
    assert_raise ParserError do
      Parser.parse_sentence([Pair.new(:noun, "cabinet"),
                              Pair.new(:stop, "the"),
                              Pair.new(:noun, "cabinet")])
    end

    assert_raise ParserError do
      Parser.parse_sentence([Pair.new(:direction, "east"),
                              Pair.new(:stop, "at"),
                              Pair.new(:noun, "princess")])
    end
  end
end