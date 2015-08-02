require_relative 'algorithms'

class KnightPathFinder
  attr_accessor :visited_positions
  attr_reader :root, :move_tree

  def initialize(starting_position)
    @root = starting_position
    @visited_positions = [@root]
    @tree_trunk = build_move_tree
  end

  def self.valid_moves(pos)
    x, y = pos
    possible_moves = [
      [x + 2, y + 1],
      [x + 2, y - 1],
      [x - 2, y + 1],
      [x - 2, y - 1],
      [x - 1, y + 2],
      [x - 1, y - 2],
      [x + 1, y + 2],
      [x + 1, y - 2]
    ]

    possible_moves.select do |position|
      position[0].between?(0, 7) && position[1].between?(0, 7)
    end
  end

  def new_move_positions(pos)
    positions = self.class.valid_moves(pos).reject do |position|
      visited_positions.include?(position)
    end

    visited_positions.concat(positions)

    positions
  end

  def build_move_tree
    root_node = PolyTreeNode.new(root)
    queue = [root_node]

    until queue.empty?
      node = queue.shift

      new_move_positions(node.value).each do |new_pos|
        child_node = PolyTreeNode.new(new_pos)
        node.add_child(child_node)
        queue += [child_node]
      end
    end

    root_node
  end

  def find_path(end_pos)
    destination_node = @tree_trunk.bfs(end_pos)
    destination_node.trace_path_back
  end
end

p KnightPathFinder.new([0,0]).find_path([6, 2])
