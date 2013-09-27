class Card
  attr_accessor :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

class Deck
  attr_accessor :cards
  def initialize
    @cards = []
    create_all_cards
  end

  def create_all_cards
    suits = [:heart, :diamond, :spade, :club]
    ranks = (1..13).to_a

    suits.each do |suit|
      ranks.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def deal_card
    rand_card = @cards.sample
    @cards.delete(rand_card)
    rand_card
  end

end

class Hand

end

class Player

end

class Game

end