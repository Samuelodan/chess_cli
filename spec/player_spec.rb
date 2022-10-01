# frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { described_class.new }

  describe '#set_name' do
    it 'assigns the argument to @name' do
      name = 'James'
      player.set_name(name)
      expect(player.name).to eql(name)
    end
  end
end

