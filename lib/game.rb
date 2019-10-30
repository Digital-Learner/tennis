# frozen_string_literal: true

# A tennis match has a number of games.
# The purpose is to correctly calculate an individual games score
class Game
  TENNIS_POINTS_SCORE = {
    0 => { points_value: 0, call_as: 'Love' },
    1 => { points_value: 15, call_as: 'Fifteen' },
    2 => { points_value: 30, call_as: 'Thirty' },
    3 => { points_value: 40, call_as: 'Forty' },
    4 => { points_value: 50, call_as: 'Game' }
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

    return call_of_game if game_won?

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

  def game_won?
    minimum_of_four_points? && !scores_equal? && two_points_clear?
  end

  def call_of_game
    [call_for_servers_score, server].join(', ')
  end

  def minimum_of_four_points?
    @points[server] >= 4 || @points[receiver] >= 4
  end

  def two_points_clear?
    (@points[server] - @points[receiver]).abs >= 2
  end
end
