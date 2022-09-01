# frozen_string_literal: true
# smart chess squares
class Square
  attr_accessor :position, :piece, :color

  def initialize
    @position = nil
    @piece = nil
    @color = nil
  end

  def draw_square
    ansi_sqr_color = color == :white ? "\e[48;2;240;217;181m" : "\e[48;2;181;136;99m"
    ansi_piece = if piece.nil?
                  "\e[30m   \e[0m"
                else
                  "\e[30m #{piece.symbol} \e[0m"
                end
    print ansi_sqr_color + ansi_piece
  end
end

