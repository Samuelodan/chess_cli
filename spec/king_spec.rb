# frozen_string_literal: true

require_relative '../lib/king'

RSpec.describe King do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnbq1bnr/pppppppp/k7/8/5K2/6P1/PPPPPP1P/RNBQ1BNR w HAha - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'f4 king has 7 moves' do
        pos = Position.for('f4')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 7
        expect(move_count).to eql(exp_count)
      end

      it 'a6 king has 3 moves' do
        pos = Position.for('a6')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 3
        expect(move_count).to eql(exp_count)
      end
    end
  end
end

