# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/encrlib/rail_fence'

class RailFenceCipherTest < Minitest::Test
  def test_rail_fence_encrypts_classic_example
    assert_equal 'WECRLTEERDSOEEFEAOCAIVDEN', Encrlib::RailFence.cipher('WEAREDISCOVEREDFLEEATONCE', 3)
  end

  def test_rail_fence_keeps_short_or_single_rail_input
    assert_equal 'abc', Encrlib::RailFence.cipher('abc', 1)
    assert_equal 'x', Encrlib::RailFence.cipher('x', 5)
  end

  def test_rail_fence_encrypts_with_two_rails
    assert_equal 'ATCADWTAKTAN', Encrlib::RailFence.cipher('ATTACKATDAWN', 2)
  end

  def test_rail_fence_encrypts_with_three_rails
    assert_equal 'HOLELWRDLO', Encrlib::RailFence.cipher('HELLOWORLD', 3)
  end

  def test_rail_fence_encrypts_digits_and_symbols
    assert_equal '135!24-', Encrlib::RailFence.cipher('12345-!', 2)
  end

  def test_rail_fence_keeps_spaces_and_cyrillic
    assert_equal 'П, рт y2!иеRb06вu2', Encrlib::RailFence.cipher('Привет, Ruby 2026!', 4)
  end

  def test_rail_fence_keeps_input_for_single_rail
    assert_equal 'abc', Encrlib::RailFence.cipher('abc', 1)
  end

  def test_rail_fence_keeps_input_when_key_is_zero_or_negative
    assert_equal 'abc', Encrlib::RailFence.cipher('abc', 0)
    assert_equal 'abc', Encrlib::RailFence.cipher('abc', -3)
  end

  def test_rail_fence_keeps_input_when_text_is_too_short
    assert_equal 'x', Encrlib::RailFence.cipher('x', 5)
    assert_equal '', Encrlib::RailFence.cipher('', 4)
  end

  def test_rail_fence_keeps_input_when_key_is_larger_than_text
    assert_equal 'abc', Encrlib::RailFence.cipher('abc', 5)
  end
end