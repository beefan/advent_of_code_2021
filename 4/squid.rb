INPUT_FILE = "input.txt"

BingoSpace = Struct.new(:value, :marked?)
BingoBoard = Struct.new(:rows)

def transform_input(file_name)
  file = File.open(file_name)
  lines = file.readlines.map { |ln| ln.chomp }
  lines.delete("")

  numbers = lines.shift.split(",").map(&:to_i)
  boards = lines.each_slice(5).map do |rows|
    transformed_rows = rows.map do |row|
      row.split(" ").map { |value| BingoSpace.new(value.to_i, false) }
    end

    BingoBoard.new(transformed_rows)
  end

  [boards, numbers]
end

def mark_boards(boards, number)
  boards.map do |board|
    rows = board.rows.map do |spaces|
      spaces.map { |space| BingoSpace.new(space.value, space.marked? || space.value == number) }
    end

    BingoBoard.new(rows)
  end
end

def check_boards(boards)
  boards.select { |board| board_is_winner?(board) }
end

def board_is_winner?(board)
  return true if board.rows.any? { |spaces| spaces.all?(&:marked?) } 

  column_count = board.rows.first.count
  columns = (1..column_count).map do |i|
    index = i - 1
    board.rows.map { |spaces| spaces[index] }
  end

  columns.any? { |spaces| spaces.all?(&:marked?) }
end

def score(board, last_number)
  sum_of_unmarked_numbers = board.rows.flatten.sum { |space| space.marked? ? 0 : space.value }

  sum_of_unmarked_numbers * last_number
end

def bingo_was_his_name_oh
  boards, numbers = transform_input(INPUT_FILE)
  winning_scores = nil

  numbers.each do |number|
    boards = mark_boards(boards, number)
    winners = check_boards(boards)
    next if winners.empty?

    winning_scores = winners.map { |winner| score(winner, number) }
    break
  end

  winning_scores
end

def last_board_standing
  boards, numbers = transform_input(INPUT_FILE)
  loser_score = nil

  numbers.each do |number|
    boards = mark_boards(boards, number)
    winners = check_boards(boards)
    next if winners.empty?

    if boards.length == 1
      loser_score = score(winners.first, number)
      break
    else
      winners.each { |winner| boards.delete(winner) }
    end
  end

  loser_score
end

# part 1
puts bingo_was_his_name_oh

# part 2
puts last_board_standing