# RUBY CHESS

![Screenshot of Board](https://github.com/Samuelodan/chess_cli/blob/main/media/main_img.png)


Written in Ruby for the command line.

## Table of Contents

- [Description](#Description)
- [Installation](#Installation)
  - [Running the tests](#Running-the-tests)
- [How to Play](#How-to-play)
- [Features](#Features)
  - [Special Moves](#Special-moves)
- [Reflection and Personal Lessons](#Reflection-and-personal-lessons)
- [Potential Improvements](#Potential-improvements)
- [Acknowledgement](#Acknowledgement)


## Description

This is a 2-player chess game that runs in the command line. Players take turns to move their pieces until there's a checkmate or stalemate, or until a player resigns mid game.

## Installation

The more convenient way to run this program is by visiting this [Replit page](https://replit.com/@Samuelodan/chesscli#README.md) and clicking the
**run** button to start the game.

If you want to run it locally though, you can clone the repo, go to the
project's root directory using `cd chess_cli/` and run these commands;

`bundle install` to install the project's dependencies and then

`ruby lib/main.rb` to run the program.

### Running the Tests
run `rspec` to run all tests or,

`rspec spec/bishop_spec.rb` (or any other spec file) to run just the tests in the file

## How to Play

If you need a refresher on the rules of chess, here's a [quick
guide](http://www.chessvariants.org/d.chess/chess.html) with illustrations.

Players move pieces using [algebraic
notation](https://en.wikipedia.org/wiki/Algebraic_notation_(chess)). It's a
really effecient method once you get the hang of it. All the squares have
positions from a1 to h8 (`a` to `h` and `1` to `8`). So, `a2a4` means "move the piece at square 'a2' to square 'a4'." Guides have been included on the sides of the board to help you remember.

## Features

### Save and Load Game Progress

During gameplay, you can enter `save` to save your progress. This save can be
loaded at the start of the program.
> insert image or GIF here

As shown above, you can load from any of 5 saves and you'll resume right where
you saved.

### Resign at any Point of the Game

Instead of entering your move, you can enter `quit` to surrender and end the
game. There's also an option at the end of each match to immediatly play another round.

### Error prompts

There are prompts throughout the game to guide you to the right output. If you
tried to make an invalid move, there's a prompt to notify you. If you try to
move your opponent's piece, there's a specific prompt telling you. There're also prompts to tell you when you have't selected a piece or when you try to make a move that places or leaves your king in check.

### Different Color Name Backgrounds

These colors help players to more easily recognise when it's their turn to make
moves. The white player has the lighter background color to their name.


### Win and Draw States

Checkmate and Stalemate have been implemented, so the game will display a prompt
and then end when the conditions are met. The there's also a prompt whenever a
king is in check, so this should serve as a fallback should the player forget to
announce check.

## Special Moves

### Pawn Promotion

![pawn
promotion](https://github.com/Samuelodan/chess_cli/blob/main/media/promotion_img.png)

According to the rules of chess, pawns that get to the other side must be
promoted to either a Queen (this is called Queening), or Rook, Knight, or Bishop
(this is referred to as Underpromotion). The same rule is enforced in this Game
as well.

### Pawn Double Move

Pawns that have not yet moved in the game can make double moves.

## Reflections and Personal Lessons






<!-- To check out the game, head over to <a href = "https://replit.com/@Samuelodan/chesscli#README.md">replit</a> and click the Run button to start. -->


