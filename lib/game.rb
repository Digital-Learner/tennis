# frozen_string_literal: true

# A tennis match has a number of games.
# The purpose is to correctly calculate an individual games score
class Game
  TENNIS_POINTS_SCORE = {
    0 => { points_value: 0, call_as: 'Love' },
    1 => { points_value: 15, call_as: 'Fifteen' },
    2 => { points_value: 30, call_as: 'Thirty' },
    3 => { points_value: 40, call_as: 'Forty' },
    4 => 'Game'
  }.freeze

  attr_reader :server, :receiver, :points

  def initialize(server, receiver)
    @server = server
    @receiver = receiver
    @points = { server => 0, receiver => 0 }
  end

  def point_to(player)
    @points[player] += 1
  end

  def score
    return [call_for_servers_score, 'all'].join('-') if scores_equal?

    [call_for_servers_score, call_for_receivers_score].join('-')
  end

  private

  def scores_equal?
    @points[server] == @points[receiver]
  end

  def call_for_servers_score
    TENNIS_POINTS_SCORE[@points[server]][:call_as]
  end

  def call_for_receivers_score
    TENNIS_POINTS_SCORE[@points[receiver]][:call_as].downcase
  end
end
