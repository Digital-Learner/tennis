# frozen_string_literal: true

# A tennis match has a number of games.
# The purpose is to correctly calculate an individual games score
class Game
  TENNIS_POINTS_SCORE = {
    0 => { points_value: 0, call_as: 'Love' },
    1 => { points_value: 15, call_as: 'Fifteen' },
    2 => { points_value: 30, call_as: 'Thirty' },
    3 => { points_value: 40, call_as: 'Forty' }
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
    return scores_equal if scores_equal?

    return call_of_advantage if advantage?

    return call_of_game if game_won?

    [call_for_servers_score, call_for_receivers_score].join('-')
  end

  private

  def scores_equal?
    @points[server] == @points[receiver]
  end

  def scores_equal
    return [call_for_servers_score, 'all'].join('-') if @points[server] < 3

    'Deuce'
  end

  def call_for_servers_score
    TENNIS_POINTS_SCORE[@points[server]][:call_as]
  end

  def call_for_receivers_score
    TENNIS_POINTS_SCORE[@points[receiver]][:call_as].downcase
  end

  def game_won?
    minimum_of_points?(4) && !scores_equal? && two_points_clear?
  end

  def call_of_game
    ['Game', points_difference_player].join(', ')
  end

  def points_difference_player
    points_difference.positive? ? server : receiver
  end

  def advantage?
    minimum_of_points?(3) && points_difference.abs == 1
  end

  def call_of_advantage
    "Advantage, #{points_difference_player}"
  end

  def points_difference
    @points[server] - @points[receiver]
  end

  def minimum_of_points?(points)
    @points[server] >= points || @points[receiver] >= points
  end

  def two_points_clear?
    points_difference.abs >= 2
  end
end
