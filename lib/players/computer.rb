module Players
  class Computer < Player
    def move(board)
      move_array = [0,1,2,3,4,5,6,7,8]
      move_array.shuffle!
      comp_input = move_array.detect { |i| board.cells[i] == " "}
      (comp_input + 1).to_s
    end
  end
end

