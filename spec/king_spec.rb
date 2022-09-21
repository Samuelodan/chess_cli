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

    context 'for fen string 2' do
      before do
        fen_str2 = 'rnbq1b1r/pppppp1p/8/1k6/3pPKn1/6P1/PPPPP2P/RNBQ1BNR w HAha - 0 1'
        board.arrange_pieces_from_fen(fen_str2)
      end

      it 'f4 king has 6 moves' do
        pos = Position.for('f4')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 6
        expect(move_count).to eql(exp_count)
      end

      it 'b5 king has 8 moves' do
        pos = Position.for('b5')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 8
        expect(move_count).to eql(exp_count)
      end
    end
  end
end

