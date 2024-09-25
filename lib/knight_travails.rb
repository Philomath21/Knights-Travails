row_a = (0..7).to_a
board_a = row_a.product(row_a)
# p board_a

# Creating graph (data structure) of adjacency lists type
# Hash includes all of the 64 blocks on the chess board as individual keys
# Their values are the blocks that can be accessed by the knight in next movefrom the key block
board_h = board_a.to_h do |key_a|
  i, j = key_a

  i2_a = [i + 2, i - 2].select { |num| (0..7).include? num }
  j1_a = [j + 1, j - 1].select { |num| (0..7).include? num }

  j2_a = [j + 2, j - 2].select { |num| (0..7).include? num }
  i1_a = [i + 1, i - 1].select { |num| (0..7).include? num }

  adjacency_a = i2_a.product(j1_a) + i1_a.product(j2_a)
  # puts "#{key_a} => #{adjacency_a}"
  [key_a, adjacency_a]
end

# pp board_h

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
