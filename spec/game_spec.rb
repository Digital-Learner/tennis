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
    describe 'when a new game before a point is played' do
      subject { described_class.new(server, receiver).score }

      it { is_expected.to eql 'Love-all' }
    end

    describe 'when server has won points' do
      it 'reports Fifteen-love' do
        game.point_to(server)

        expect(game.score).to eql 'Fifteen-love'
      end

      it 'reports Thirty-love' do
        2.times { game.point_to(server) }

        expect(game.score).to eql 'Thirty-love'
      end

      it 'reports Forty-love' do
        3.times { game.point_to(server) }

        expect(game.score).to eql 'Forty-love'
      end

      it 'reports Game, J' do
        4.times { game.point_to(server) }

        expect(game.score).to eql 'Game, J'
      end
    end

    describe 'server has 3 points and receiver has 1 point [J, J, B, J]' do
      it 'reports Forty-fifteen' do
        3.times { game.point_to(server) }
        game.point_to(receiver)

        expect(game.score).to eql 'Forty-fifteen'
      end
    end

    describe 'when both players have won points with equal scores' do
      it 'reports Fifteen-all' do
        game.point_to(server)
        game.point_to(receiver)

        expect(game.score).to eql 'Fifteen-all'
      end

      it 'reports Thirty-all' do
        2.times { game.point_to(receiver) }
        2.times { game.point_to(server) }

        expect(game.score).to eql 'Thirty-all'
      end

      it 'reports Deuce when above 3 points' do
        3.times { game.point_to(receiver) }
        3.times { game.point_to(server) }

        expect(game.score).to eql 'Deuce'
      end
    end

    describe 'when at least 3 points scored by both players' do
      # Points won: J,B,J,B,J,B,B
      # rubocop:disable RSpec/ExampleLength
      it 'reports Advantage, B when receiver has one more point' do
        game.point_to(server)
        game.point_to(receiver)
        game.point_to(server)
        game.point_to(receiver)
        game.point_to(server)
        game.point_to(receiver)
        game.point_to(receiver)

        expect(game.score).to eq 'Advantage, B'
      end

      it 'reports Advantage, J when server has one more point' do
        game.point_to(server)
        game.point_to(receiver)
        game.point_to(server)
        game.point_to(receiver)
        game.point_to(server)
        game.point_to(receiver)
        game.point_to(server)

        expect(game.score).to eq 'Advantage, J'
      end
      # rubocop:enable RSpec/ExampleLength
    end

    describe 'a win' do
      # Points won: J,J,J,B,B,B,B,B
      it 'reports Game, B' do
        3.times { game.point_to(server) }
        5.times { game.point_to(receiver) }

        expect(game.score).to eq 'Game, B'
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
