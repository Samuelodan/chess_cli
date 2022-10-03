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
    context 'when current player is player1' do
      it 'changes @current_player to player2' do
        expect do
          chess_game.change_turn
        end.to change { chess_game.current_player }.to(player2)
      end
    end

    context 'when current player is player2' do
      before do
        chess_game.instance_variable_set(:@current_player, player2)
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
end

