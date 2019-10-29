

class Game
  attr_reader :server, :receiver, :points

  def initialize(server, receiver)
    @server = server
    @receiver = receiver
    @points = { server => 0, receiver => 0 }
  end
end
