# board array containing 64 blocks on the chess board:
# e.g [[0, 0], [0, 1], ...,[7, 6], [7, 7]]
line_a = (0..7).to_a
board_a = line_a.product line_a

# Creating graph (data structure) of adjacency lists type
# Hash includes 64 blocks as individual key & adjacency array as its value
# (array containing blocks that can be accessed by the knight in next move)
# e.g [0,0] => [[1,2], [2,1]]

board_h = board_a.to_h do |i, j|
  adjacency_a = [i + 2, i - 2].product([j + 1, j - 1]) +
                [i + 1, i - 1].product([j + 2, j - 2])
  adjacency_a.select! { |block| block.all? { |num| (0..7).include? num } }

  [[i, j], adjacency_a] # key-value pair
end

# knight_moves method shows the shortest possible way to get from one
# square (source) to another (dest) by outputting all squares (match_step)
# the knight will stop on along the way.
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

def knight_moves(source, dest, hash)
  match_step = source
  route = []
  loop do
    route.push match_step
    adjacency_a = hash[match_step]
    return route + [dest] if adjacency_a.include? dest

    match_step = adjacency_a.find do |i_step, j_step|
      check1i = (dest[0] - i_step).abs <= 2
      check1j = (dest[1] - j_step).abs <= 2
      check1i && check1j
    end

    next unless match_step.nil?

    match_step = adjacency_a.find do |i_step, j_step|
      check2i = ((source[0]..dest[0]).to_a + (dest[0]..source[0]).to_a).include? i_step
      check2j = ((source[1]..dest[1]).to_a + (dest[1]..source[1]).to_a).include? j_step
      check2i && check2j
    end
  end
end

p knight_moves([0, 0], [7, 7], board_h)
