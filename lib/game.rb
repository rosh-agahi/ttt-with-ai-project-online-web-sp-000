class Game 
  
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Right column
  [1,4,7], # Middle column
  [2,5,8], # Left column
  [0,4,8], # Diagonal 1
  [2,4,6]  # Diagonal 2
  ]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  

  def current_player
    if @board.turn_count % 2 == 0
      player_1
    else
      player_2
    end
  end
  
  def won?
    WIN_COMBINATIONS.detect do |winner|
      @board.cells[winner[0]] == @board.cells[winner[1]] &&
      @board.cells[winner[1]] == @board.cells[winner[2]] &&
      (@board.cells[winner[0]] == "X" || @board.cells[winner[0]] == "O")
    end
  end
  
  def draw?
    @board.full? && !won?
  end
  
  def over?
    won? || draw?
  end
  
  def winner
    if winning_combo = won?
      @winner = @board.cells[winning_combo.first]
    end
  end
  
  def turn
    puts "What's your next move, #{self.current_player.token}?"
    x = current_player.move(board)
    if @board.valid_move?(x)
      @board.update(x,current_player)
    else
      turn
    end
    @board.display
  end
    
  def play 
    turn until over?
    if draw?
      puts "Cat's Game!" 
    else
      puts "Congratulations #{winner}!"
    end
  end
end
