# frozen_string_literal: true

# smart positions to replace primitive objects
class Position
  attr_reader :file, :rank

  def initialize(file:, rank:)
    @file = file
    @rank = rank
  end

  def eql?(other)
    file == other.file && rank == other.rank
  end

  def up
    if rank == 8
      return self
    end

    new_rank = rank.next
    Position.new(file: file, rank: new_rank)
  end

  def down
    if rank == 1
      return self
    end

    new_rank = rank.pred
    Position.new(file: file, rank: new_rank)
  end
end

