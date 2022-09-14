# frozen_string_literal: true

# smart positions to replace primitive objects
class Position
  attr_reader :file, :rank

  def initialize(file:, rank:)
    @file = file
    @rank = rank
  end

  def ==(other)
    file == other.file && rank == other.rank
  end

  def up
    new_rank = rank.next
    Position.new(file: file, rank: new_rank)
  end
end

