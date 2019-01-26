class Game
  attr_accessor :board, :player_1, :player_2, :timer

  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count.even?  ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      board.cells[combo[0]] == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]] && board.cells[combo[0]] != " "
    end
  end

  def draw?
    board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    board.cells[won?[0]] if won?
  end

  def turn
    puts "It's now #{current_player.token}'s turn."
    input = current_player.move(board).to_i
    if board.valid_move?(input)
      board.update(input, current_player)
      board.display
    else
      puts "That is an invalid move, please try again."
      turn
    end
  end

  def play
    board.reset!
    board.display
    until over?
      turn
    end
    if draw?
      puts "Cat's Game!"
      break
    elsif won?
      puts "Congratulations #{current_player.token}!"
      break
    end
  end

  # def wargames
  #   @counter = 0
  #   x = 0
  #   o = 0
  #   draw = 0
  #   until @counter == 100
  #     @counter += 1
  #     play
  #     if draw?
  #       draw += 1
  #     elsif winner == "X"
  #       x += 1
  #     elsif winner == "O"
  #       o += 1
  #     end
  #     sleep(@timer*1.5)
  #     @timer -= (@timer/3)
  #   end
  #   puts "This round had #{x} wins for X, #{o} wins for O, and #{draw} draws."
  #   puts "A STRANGE GAME. THE ONLY WINNING MOVE IS NOT TO PLAY."
  #   puts "HOW ABOUT A NICE GAME OF CHESS?"
  # end
end
