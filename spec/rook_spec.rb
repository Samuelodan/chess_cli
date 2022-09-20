# frozen_string_literal: true

require_relative '../lib/rook'

RSpec.describe Rook do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnbqkb2/pppppppp/7n/7r/P3R3/2NB4/1PPPPPPP/R2QKBN1 w Qq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'a1 rook has 4 moves' do
        pos = Position.for('a1')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 4
        expect(move_count).to eql(exp_count)
      end

      it 'e4 rook has 10 moves' do
        pos = Position.for('e4')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 10
        expect(move_count).to eql(exp_count)
      end

      it 'h5 rook has 10 moves' do
        pos = Position.for('h5')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 10
        expect(move_count).to eql(exp_count)
      end

      it 'a8 rook has zero moves' do
        pos = Position.for('a8')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 0
        expect(move_count).to eql(exp_count)
      end
    end

    context 'for fen string 2' do
      before do
        fen_str2 = '1nbqkb2/pppp1ppp/r6n/4pr2/P3R3/1RNB4/1PPPPPPP/3QKBN1 w - - 0 1'
        board.arrange_pieces_from_fen(fen_str2)
      end

      it 'b3 rook has 5 moves' do
        pos = Position.for('b3')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 5
        expect(move_count).to eql(exp_count)
      end

      it 'e4 rook has 8 moves' do
        pos = Position.for('e4')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 8
        expect(move_count).to eql(exp_count)
      end

      it 'f5 rook has 6 moves' do
        pos = Position.for('f5')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 6
        expect(move_count).to eql(exp_count)
      end

      it 'a6 rook has 8 moves' do
        pos = Position.for('a6')
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

