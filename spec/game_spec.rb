require './lib/game'

RSpec.describe "Game" do
  describe "#initialize" do
    it "score is love all" do
      server = "j"
      receiver = "b"
      game = Game.new(server, receiver)
      expect(game.score).to eql( { server => "love", receiver => "love"} ) 
    end
  end

  describe "Player 1 wins first point" do
    it "has score 15:love" do
      server = "j"
      receiver = "b"
      game = Game.new(server, receiver)
      game.point_to(server)
      expect(game.score).to eql( { server => "15", receiver => "love"} )
    end
  end
end
