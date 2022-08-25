# frozen_string_literal: true

require_relative './square.rb'

# board for the chess game
class Board
  attr_accessor :squares

  def initialize
    @squares = nil
  end

  def create_squares
    sqs = Array.new(8) { Array.new(8) }
    sqs.each_with_index do |row, row_idx|
      row.each_with_index do |item, idx|
        sqs[row_idx][idx] = Square.new
      end
    end
    sqs
  end
end

