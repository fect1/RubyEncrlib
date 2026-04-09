# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/encrlib/caesar'

class CaesarCipherTest < Minitest::Test
  def test_caesar_encrypts_english_alphabet
    assert_equal 'UVWXYZABCDEFGHIJKLMNOPQRSTuvwxyzabcdefghijklmnopqrst',
                 Encrlib::Caesar.caesar_cipher('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', 20)
  end

  def test_caesar_encrypts_russian_alphabet
    assert_equal 'йклмнопрстуфхцчшщъыьэюяабвгдеёжзиЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯАБВГДЕЁЖЗИ',
                 Encrlib::Caesar.caesar_cipher('абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ', 10)
  end

  def test_caesar_encrypts_digits
    assert_equal '589', Encrlib::Caesar.caesar_cipher('256', 3)
  end

  def test_caesar_keeps_other_symbols
    assert_equal '!@#$%^&*()/*-+.?|<>', Encrlib::Caesar.caesar_cipher('!@#$%^&*()/*-+.?|<>', 121)
  end
end
