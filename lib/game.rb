# frozen_string_literal: true

# A tennis match has a number of games.
# The purpose is to correctly calculate an individual games score
class Game
  attr_reader :server, :receiver, :points

  def initialize(server, receiver)
    @server = server
    @receiver = receiver
    @points = { server => 0, receiver => 0 }
  end
end
