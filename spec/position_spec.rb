# frozen_string_literal: true

require_relative '../lib/position'

RSpec.describe Position do
  subject(:position) { described_class.new(file: 'a', rank: 1) }
end

