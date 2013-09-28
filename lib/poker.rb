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
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def <=>(other_hand)
    # -1, 0, 1
  end

  def type # [:Full_House, 10]
    return check_royal_flush if check_royal_flush
    return check_straight_flush if check_straight_flush
    return check_four_of_a_kind if check_four_of_a_kind
    return check_full_house if check_full_house
    return check_flush if check_flush
    return check_straight if check_straight
    # :Straight if straight?
    # :Three_of_a_Kind if three_of_a_kind?
    # :Two_Pair if two_pair?
    # :Pair if pair?
  end
  def combo
    type[0]
  end

  def check_royal_flush
    ranks = []
    suits = []

    @cards.each do |card|
      ranks << card.rank
      suits << card.suit
    end

    ranks = ranks.sort
    ranks.each_with_index do |rank, index|
      if rank != index + 10
        return nil
      end
    end

    return nil if suits.uniq.length != 1
    [:Royal_Flush, suits[0]]
  end

  def check_straight_flush
    ranks = []
    suits = []
    temp_ranks = []

    @cards.each do |card|
      ranks << card.rank
      suits << card.suit
    end

    rank = ranks.sort

    ranks.each do |rank|
      temp_ranks << rank - ranks[0]
    end

    return nil if temp_ranks != [0, 1, 2, 3, 4] || suits.uniq.length != 1
    [:Straight_Flush, suits[0]]
  end

  def check_four_of_a_kind
    ranks = @cards.map { |card| card.rank }
    kind = ranks.sort[2]
    ranks.delete(kind)
    return nil if ranks.length != 1

    [:Four_of_a_Kind, kind]
  end

  def check_full_house
    ranks = @cards.map { |card| card.rank }
    kind = ranks.sort[2]
    ranks.delete(kind)
    ranks.delete(ranks[0])
    return nil if ranks.length != 0

    [:Full_House, kind]
  end

  def check_flush
    ranks = []
    suits = []

    @cards.each do |card|
      ranks << card.rank
      suits << card.suit
    end

    return nil if suits.uniq.length != 1
    [:Flush, ranks.sort.last]
  end

  def check_straight

  end


end

class Player

end

class Game

end