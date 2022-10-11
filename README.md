# CLI Chess

![Screenshot of Board](https://github.com/Samuelodan/chess_cli/blob/main/media/main_img.png)


Written in Ruby for the command line.

## Table of Contents

- [Description](#Description)
- [Installation](#Installation)
  - [Running the tests](#Running-the-tests)
- [How to Play](#How-to-play)
- [Features](#Features)
  - [Special Moves](#Special-moves)
- [Reflections and Personal Lessons](#Reflections-and-personal-lessons)
- [Potential Improvements](#Potential-improvements)
- [Acknowledgement](#Acknowledgement)
- [Contact](#Contact)


## Description

This is a 2-player chess game that runs in the command line. Players take turns to move their pieces until there's a checkmate or stalemate, or until a player resigns mid game.

## Installation

The more convenient way to run this program is by visiting this [Replit page](https://replit.com/@Samuelodan/chesscli#README.md) and clicking the
**run** button to start the game.

If you want to run it locally though, you can clone the repo, go to the
project's root directory using `cd chess_cli/` and run these commands;

> You should have Ruby version 2.7 (and above) installed to run this program properly, though,
> 2.5 might work fine.

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

![load_screen](https://github.com/Samuelodan/chess_cli/blob/main/media/load_save_img.png)

As shown above, you can load from any of 5 saves and you'll resume right where
you left.

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

I remember being very scared at the start of this project, cos I wasn't sure how
I would implement many features. Even displaying the colorful board in
the terminal seemed impossible. But I learnt that by just starting with the
easiest tasks, all the others will into place gradually. As someone I know said, Chess should not be
seen as one gigantic project, but as a combination of many small projects.

I had the opportunity to use 16 bit ANSI colors for the first time, a
self-registering factory design pattern for creating the pieces, inheritance on
a large scale, and many other small things I hadn't put to use before.

## Potential Improvements

### UI Showing Possible Moves

I'd like to add the option of selecting any piece and seeing all it's possible
moves show up on the board. It'll look clunky for sure, but my hope is that
it'll serve as training wheels for people newer to chess until they feel more
confident about where every piece can go.

### Overriding Save Files Upon Load

I want to make it so that you can't save multiple instances of the same match.
Once a save file is loaded, it'll be deleted and the players will have the
option to save again if they wish to return to it.

### Basic AI that Players Can Play Against

Right now, you have to be two players to enjoy the game, but it'd be fun to be
able to play against the computer.

### Castling and En Passant

I ommited these features mostly because of a time constraint. Not many beginners
seek out these moves, but anyone who has taken chess seriously in the past will
expect to be able to make, at least, one of these moves, so I'll try to add them
in the future.

### More Robust Test Coverage

Right now, all the core mechanisms of the piece movement, win and draw states,
pawn promotion, and several others are well covered, as I've written about 200
unit tests. But the Game class which brings everything together and determines
the game flow and user interaction is poorly tested. While I don't know how to
write more integration type tests, there are still message expectation tests
that I can make, so I'll try to cover as much as I reasonably can with unit
tests.

### Give Option to Start Game from FEN String

Right now, I only use FEN strings to set up the board for tests (more on that in the
acknowledgments), but I would like to let players start their own games from
FEN. I'll likely wait to have the other special moves first since FEN holds
valuable information about them.

## Acknowledgement

#### [The Odin Poject](https://www.theodinproject.com/)
I want to thank The Odin Project for providing
me with the resources to learn most what I know about actual programming. I wouldn't have had
anything to do with Ruby if not for them. Their Discord community has also
provided me with the much needed support in my coding journey thus far. 

This project is the final project in their pure Ruby course. It's supposed to
be a culmination of everything I've learned about Ruby until now and I must say,
I feel a lot more competent as a developer after having built chess.

#### Lichess.org

By using Lichess's [Board Editor](https://lichess.org/editor), I was able to
easily set up chess scenarios, grab the FEN string for said scenaraio, and
import into my game to recreate the board and set test expectations. My game may
not look it, but it can load up any FEN string internally, and arrange the board
accordingly.

## Contact

Please feel free to reach out if you have any questions or suggestions.

Thanks for reading.




