# frozen_string_literal: true

# Напишите тесты для реализации стека. Должны быть протестированы методы:

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new([1, 2, 3])
  end

  def test_push_adds_an_element
    expected_stack = [1, 2, 3, 4]

    assert { @stack.push!(4) == expected_stack }
  end

  def test_pop_deletes_the_last_element
    expected_stack = [1, 2]

    @stack.pop!

    assert_equal(@stack.to_a, expected_stack)
  end

  def test_clear_deletes_all_elements
    @stack.clear!

    assert { @stack.empty? }
  end

  def test_empty_checks_if_empty
    assert { @stack.size == 3 }
    refute { @stack.size.zero? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
