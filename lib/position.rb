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

  def ==(other)
    file == other.file && rank == other.rank
  end

  def hash
    "#{file}#{rank}".hash
  end

  def up
    new_rank = rank.next
    Position.new(file: file, rank: new_rank)
  end

  def down
    new_rank = rank.pred
    Position.new(file: file, rank: new_rank)
  end

  def left
    new_file = (file.ord - 1).chr
    Position.new(file: new_file, rank: rank)
  end

  def right
    new_file = file.next
    Position.new(file: new_file, rank: rank)
  end

  def self.for(pos_str)
    new_file = pos_str[0]
    new_rank = pos_str[1].to_i
    Position.new(file: new_file, rank: new_rank)
  end
end

