# frozen_string_literal: true

require './lib/game'

RSpec.describe Game do
  let(:game) { described_class.new(server, receiver) }

  let(:server) { 'J' }
  let(:receiver) { 'B' }

  describe '#initialize' do
    it 'points are 0 (server) - 0 (receiver)' do
      expect(game.points).to be_a(Hash)
      expect(game.points[server]).to eq 0
      expect(game.points[receiver]).to eq 0
    end
  end

  describe '#score' do
    context 'when a new game before a point is played' do
      subject { described_class.new(server, receiver).score }

      it { is_expected.to eql 'Love-all' }
    end

    context 'when server has won first point' do
      it 'reports Fifteen-love' do
        game.point_to(server)

        expect(game.score).to eql 'Fifteen-love'
      end
    end
  end

  describe '#point_to(player)' do
    it 'when server correctly increments by 1' do
      expect { game.point_to(server) }.to change { game.points[server] }
        .from(0).to(1)
      expect { game.point_to(server) }.not_to change { game.points[receiver] }
    end

    it 'when receiver correctly increments by 1' do
      expect { game.point_to(receiver) }.to change { game.points[receiver] }
        .from(0).to(1)
      expect { game.point_to(receiver) }.not_to change { game.points[server] }
    end
  end
end
