# frozen_string_literal: true

require './lib/game'

RSpec.describe 'Game' do
  describe '#initialize' do
    it 'points are 0 (server) - 0 (receiver)' do
      server = 'J'
      receiver = 'B'
      game = Game.new(server, receiver)
      expect(game.points).to be_a(Hash)
      expect(game.points[server]).to eq 0
      expect(game.points[receiver]).to eq 0
    end
  end

  describe '#score' do
    context 'for a new game before a point is played' do
      subject { Game.new('J', 'B').score }
      it { is_expected.to equal 'Love-all' }
    end
  end
end
