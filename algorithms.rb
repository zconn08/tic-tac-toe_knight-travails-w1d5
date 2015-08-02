class PolyTreeNode
  attr_accessor :children
  attr_reader :value, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    parent.children.delete(self) unless parent.nil?

    @parent = node
    unless node.nil?
      node.children << self unless node.children.include?(self)
    end
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "NOT A CHILD!!!" unless children.include?(node)
    node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    queue = [self]

    while queue.length > 0
      node = queue.shift
      return node if node.value == target
      queue += node.children
    end

    nil
  end

  def trace_path_back
    path = [self.value]
    current_node = self

    until current_node.parent.nil?
      current_node = current_node.parent
      path.unshift(current_node.value)
    end

    path
  end
end
