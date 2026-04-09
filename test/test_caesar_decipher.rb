# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/encrlib/caesar'

class CaesarCipherTest < Minitest::Test
  def test_caesar_encrypts_english_alphabet
    assert_equal 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
                 Encrlib::Caesar.caesar_decipher('UVWXYZABCDEFGHIJKLMNOPQRSTuvwxyzabcdefghijklmnopqrst', 20)
  end

  def test_caesar_encrypts_russian_alphabet
    assert_equal 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ',
                 Encrlib::Caesar.caesar_decipher('йклмнопрстуфхцчшщъыьэюяабвгдеёжзиЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯАБВГДЕЁЖЗИ', 10)
  end

  def test_caesar_encrypts_digits
    assert_equal '256', Encrlib::Caesar.caesar_decipher('589', 3)
  end

  def test_caesar_keeps_other_symbols
    assert_equal '!@#$%^&*()/*-+.?|<>', Encrlib::Caesar.caesar_decipher('!@#$%^&*()/*-+.?|<>', 121)
  end
end
