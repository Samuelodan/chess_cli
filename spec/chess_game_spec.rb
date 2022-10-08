# frozen_string_literal: true

require_relative '../lib/chess_game.rb'

RSpec.describe ChessGame do
  subject(:chess_game) do
    described_class.new(board: board,
                        player1: player1,
                        player2: player2)
  end
  let(:board) { Board.new }
  let(:player1) { Player.new }
  let(:player2) { Player.new }

  describe '#change_turn' do
    before do
      player1.set_color(:white)
      player2.set_color(:black)
    end

    context 'when current player is player1' do
      it 'changes @current_player to player2' do
        expect do
          chess_game.change_turn
        end.to change { chess_game.current_player }.to(player2)
      end
    end

    context 'when current player is player2' do
      before do
        chess_game.instance_variable_set(:@current_color, :black)
      end

      it 'changes @current_player to player1' do
        expect do
          chess_game.change_turn
        end.to change { chess_game.current_player }.to(player1)
      end
    end
  end

  describe '#assign_player_attributes' do
    before do
      allow(chess_game).to receive(:collect_name).and_return('name1', 'name2')
      allow(player1).to receive(:set_name)
      allow(player2).to receive(:set_name)
    end

    it 'sends #set_name to both players', :aggregate_failures do
      expect(player1).to receive(:set_name).with('name1')
      expect(player2).to receive(:set_name).with('name2')
      chess_game.assign_player_attributes
    end

    it 'sends #set_color to both players', :aggregate_failures do
      expect(player1).to receive(:set_color).with(:white)
      expect(player2).to receive(:set_color).with(:black)
      chess_game.assign_player_attributes
    end
  end

  describe '#valid_move_input?' do
    context 'when input is valid' do
      before do
        pc = Pawn.new(letter: 'p')
        allow(board).to receive(:piece_from_str).and_return(pc)
        allow(board).to receive(:update_targ_and_dest)
        allow(board).to receive(:is_move_legal?).and_return(true)
        allow(player1).to receive(:color).and_return(:black)
      end

      xit 'returns true' do
        mock_input = 'a4a5'
        result = chess_game.valid_move_input?(mock_input)
        expect(result).to be true
      end
    end

    context 'when input is invalid' do
      context 'when input is in the wrong format' do
        before do
          allow(board).to receive(:piece_from_str)
        end

        it 'returns false' do
          mock_input = 'a9j5'
          result = chess_game.valid_move_input?(mock_input)
          expect(result).to be false
        end
      end

      context 'when no piece is selected' do
        before do
            pc = nil
          allow(board).to receive(:piece_from_str).and_return(pc)
          allow(board).to receive(:update_targ_and_dest)
          allow(board).to receive(:is_move_legal?).and_return(true)
          allow(player1).to receive(:color).and_return(:black)
        end

        it 'returns false' do
          mock_input = 'a4a5'
          result = chess_game.valid_move_input?(mock_input)
          expect(result).to be false
        end
      end

      context "when opponent's piece is selected" do
        before do
            pc = Pawn.new(letter: 'P')
          allow(board).to receive(:piece_from_str).and_return(pc)
          allow(player1).to receive(:color).and_return(:black)
        end

        xit 'returns false' do
          mock_input = 'a4a5'
          result = chess_game.valid_move_input?(mock_input)
          expect(result).to be false
        end
      end
    end
  end
end

