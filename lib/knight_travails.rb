# board array containing 64 squares on the chess board:
# e.g [[0, 0], [0, 1], ...,[7, 6], [7, 7]]
def create_board
  line_a = (0..7).to_a
  line_a.product line_a
end

# Creating graph (data structure) of adjacency lists type
# Hash includes 64 squares as individual key & adjacency array as its value
# (array containing squares that can be accessed by the knight in next move)
# e.g [0,0] => [[1,2], [2,1]]
def create_knight_graph
  create_board.to_h do |x, y|
    adj_squares = [x + 2, x - 2].product([y + 1, y - 1]) +
                  [x + 1, x - 1].product([y + 2, y - 2])
    adj_squares.select! { |square| square.all? { |num| (0..7).include? num } }

    [[x, y], adj_squares] # key-value pair
  end
end

# knight_moves method shows the shortest possible way to get from one
# square (source) to another (dest) by outputting all squares (stops)
# the knight will stop on along the way.
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

def knight_moves(source, dest)
  stop = source
  route = [] # will contain source, dest & all the stops in between
  knight_graph = create_knight_graph

  adj_check = proc do |square1, square2|
    knight_graph[square2].include? square1
  end

  towards_dest_check = proc do |square|
    [square, source, dest] in [[x, y], [xs, ys], [xd, yd]]
    check_x = (xs - 1..xd + 2).include?(x) || (xd - 2..xs + 1).include?(x)
    check_y = (ys - 1..yd + 2).include?(y) || (yd - 2..ys + 1).include?(y)
    check_x && check_y
  end

  loop do
    route.push stop
    return route + [dest] if adj_check.call(stop, dest)

    adj_squares = knight_graph[stop]
    stop = adj_squares.find { |square| adj_check.call(square, dest) }
    next unless stop.nil?

    stop = adj_squares.find { |square| towards_dest_check.call(square) }
  end
end
