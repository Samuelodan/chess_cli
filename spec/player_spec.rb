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

  describe '#set_color' do
    it 'assigns the argument to @color' do
      color = :white
      player.set_color(color)
      expect(player.color).to eql(color)
    end
  end
end

