# frozen_string_literal: true

require './lib/game'

RSpec.describe Game do
  let(:server) { 'J' }
  let(:receiver) { 'B' }
  subject { described_class.new(server, receiver) }

  describe '#initialize' do
    it 'points are 0 (server) - 0 (receiver)' do
      expect(subject.points).to be_a(Hash)
      expect(subject.points[server]).to eq 0
      expect(subject.points[receiver]).to eq 0
    end
  end

  describe '#score' do
    context 'for a new game before a point is played' do
      subject { described_class.new(server, receiver).score }
      it { is_expected.to equal 'Love-all' }
    end
  end
end
