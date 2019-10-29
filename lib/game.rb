

class Game
  attr_reader :server, :receiver, :score, :points

  def initialize(server, receiver)
    @server = server
    @receiver = receiver
    @score = { server => "love", receiver => "love" }
    @points = 0
  end

  def point_to(player)
    case @score[player]
    when "love"
      @score[player] = "15"
    when "15"
      @score[player] = "30"
    when "30"
      @score[player] = "40"
    when "40"
      # duce? ? @score[player] = ":
    end
    @points += 1
    @score
  end

  private

  def duce?
    return @score[server] == @score[receiver] if @points > 2
    false
  end
end