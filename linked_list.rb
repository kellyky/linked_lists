# frozen_string_literal: true

# LinkedList class with methods to append, prepend, etc. new nodes to the list
class LinkedList
  attr_reader :size, :head, :tail

  def initialize
    @size = 0
    @tail = nil
    @head = nil
  end

  def append(value)
    @size += 1

    if @tail.nil?
      @tail = Node.new(value)
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end

    @head = @tail if @head.nil?
  end

  def prepend(value)
    @size += 1
    @head = Node.new(value, @head)
    @tail = @head if @tail.nil?
  end

  def at(index)
    current_node = @head
    i = 0
    until current_node.nil?
      return current_node if i == index

      i += 1
      current_node = current_node.next_node
    end
  end

  def pop
    current_node = @head
    current_node = current_node.next_node until current_node.next_node == @tail

    current_node.next_node = nil
    @tail = current_node
  end

  def contains?(value)
    current_node = @head
    until current_node.nil?
      return true if value == current_node.value

      current_node = current_node.next_node
    end
    false
  end

  def insert_at(value, index)
    return prepend(value) if index.zero?
    return if index > @size

    previous_node = at(index - 1)
    new_node = Node.new(value, at(index))
    previous_node.next_node = new_node
    @size += 1
  end

  def remove_at(index)
    return if index >= @size

    pre_removal_node = at(index - 1)
    post_removal_node = at(index + 1)
    pre_removal_node.next_node = post_removal_node

    @size -= 1
  end

  def to_s
    values = ''
    current_node = @head

    until current_node.nil?
      values += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    puts "#{values} nil"
  end
end

# Create individual node
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @next_node = next_node
    @value = value
  end
end

list = LinkedList.new
list.append(1)
list.append(2)
list.prepend(0)
list.append(3)
list.prepend(-1)
list.to_s
list.insert_at('A', 0)
list.to_s
list.insert_at('A', 1)
list.to_s
list.remove_at(3)
list.to_s
puts list.size
