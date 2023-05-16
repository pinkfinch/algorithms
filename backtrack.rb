# One of the most classical problems that can be solved with the backtracking algorithm is the N-Queen puzzle.
# The N-queens puzzle is the problem of placing N queens on an [N×N] chessboard such that no two queens can attack each other.
# One is asked to count the number of solutions to place the N queens on the board.
# As a reminder, a queen can attack any piece that is situated at the same row, column or diagonal of the queue.
# As shown in the board below, if we place a queen at the row 1 and column 1 of the board, we then cross out all
# the cells that could be attacked by this queen.


def total_n_queens(n)
  count = 0
  hash = {}
  traverse =-> (row, col, count) {
      (0...n).each {|c|
          if queen_not_under_attack [row,c], hash
              place_remove_queen [row,c], hash, n, true
              if row == n-1
                  count += 1
                  return
              else
                  traverse.call(row+1, c, count)
              end
              place_remove_queen [row,c], hash, n, false
          end
      }
  }
  traverse.call(0, 0, count)
  count
end

def queen_not_under_attack pos, hash
  return true if !hash[pos]
  false
end

def place_remove_queen pos, hash, n, place
  x = pos[0]
  y = pos[1]
  (0...n).each {|i|
      (0...n).each {|j|
          if x == i || y == j || (i-x).abs == (j-y).abs
              if place
                  hash[[i,j]] ? hash[[i,j]] += 1 : hash[[i,j]] = 1
              else
                  hash[[i,j]] > 1 ? hash[[i,j]] -= 1 : hash.delete([i,j])
              end
          end
      }
  }
end

pp total_n_queens 4
