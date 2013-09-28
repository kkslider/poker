require 'rspec'
require_relative '../lib/poker'

describe Card do
  #hash? for num
  subject(:card) { Card.new(5, :heart) }

  describe "#initialize" do
    it "card.rank should equal 5" do
      expect(card.rank).to eq(5)
    end

    it "card.suit should equal :heart" do
      expect(card.suit).to eq(:heart)
    end
  end




end

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "deck should be array of 52 Cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "each card should be a Card object" do
      expect { deck.cards.all? { |card| card.class == Card } }.to be_true
    end
  end

  describe "#deal_card" do
    it "deck length should decrease by one" do
      current_length = deck.cards.length
      deck.deal_card
      expect(deck.cards.length).to eq(current_length - 1)
    end
  end
end


describe Hand do
  subject(:hand) { Hand.new }

  describe "#initialize" do
    # it "@cards should be an array of length 5" do
#       expect(hand.cards.length).to eq(5)
#     end

    it "@cards should all be Card objects" do
      expect{ hand.cards.all? { |card| card.class == Card } }.to be_true
    end
  end

  describe "#combo" do
    it "Hand with A_Diamond, K_Diamond, Q_Diamond, J_Diamond, 10_Diamond" do
      hand.cards = [Card.new(14, :diamond), Card.new(13, :diamond), Card.new(12, :diamond), Card.new(11, :diamond), Card.new(10, :diamond)]
      expect(hand.combo).to eq(:Royal_Flush)
    end

    it "Hand with 3_Club, 3_Spade, 3_Diamond, 6_Club, 6_Heart should be full house" do
      hand.cards = [Card.new(3, :club), Card.new(3, :spade), Card.new(3, :diamond), Card.new(6, :club), Card.new(6, :heart)]
      expect(hand.combo).to eq(:Full_House)
    end

    it "Hand with a 10_Spade, 10_Heart, 3_Club, 4_Heart, 8_Diamond should be pair" do
      hand.cards = [Card.new(10, :spade), Card.new(4, :heart), Card.new("A", :club), Card.new(10, :heart), Card.new(3, :diamond)]
      expect(hand.combo).to eq(:Pair)
    end

    it "Hand with Q_Club, 10_Club, 7_Club, 6_Club, 4_Club should be flush" do
      hand.cards = [Card.new(12, :club), Card.new(10, :club), Card.new(7, :club), Card.new(6, :club), Card.new(4, :club)]
      expect(hand.combo).to eq(:Flush)
    end

    it "Hand with a 6_Heart, 7_Club, 8_Diamond, 9_Club, 10_Spade should be a straight" do
      hand.cards = [Card.new(6, :heart), Card.new(7, :club), Card.new(8, :diamond), Card.new(9, :club), Card.new(10, :spade)]
      expect(hand.combo).to eq(:Straight)
    end

    it "Hand with 4_Heart, 10_Heart, A_Club, 5_Heart, 2_Diamond should return nil" do
      high_card = Card.new(14, :club)
      hand.cards = [Card.new(4, :heart), Card.new(10, :heart), high_card, Card.new(5, :heart), Card.new(2, :diamond)]
      expect(hand.combo).to eq(high_card)
    end

    it "Hand with 9Club, 9_Spade, 9_Diamond, 9_Heart, J_Heart" do
      hand.cards = [Card.new(9, :club), Card.new(9, :spade), Card.new(9, :diamond), Card.new(9, :heart), Card.new(11, :Heart)]
      expect(hand.combo).to eq(:Four_of_a_Kind)
    end
  end

  # describe "#hand_rankings" do
  #   let(:royal_flush_hand)
  #   let(:two_pair_hand)
  #
  #
  #   it "Royal Flush should be ranked with a higher(larger) value than a Two Pair" do
  #     expect(royal_flush_hand > two_pair_hand).to be_true
  #     expect(hand.hand_rankings["Royal Flush"] > hand.hand_rankings["Two Pair"]).to be_true
  #   end
  #
  #   it "Full House should be ranked with a higher(larger) value than a Flush" do
  #     expect(hand.hand_rankings["Full House"] > hand.hand_rankings["Flush"]).to be_true
  #   end
  # end

  describe "#high" do
    it "Hand with 3_Diamond, 4_Heart, 10_Spade, 6_Club, 7_Heart to return 10_Spade" do
      high_card = Card.new(10, :spade)
      hand.cards = [Card.new(3, :diamond), Card.new(4, :heart), high_card, Card.new(6, :club), Card.new(7, :heart)]
      expect(hand.high).to eq(high_card)
    end
  end
end