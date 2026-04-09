# frozen_string_literal: true

module Encrlib
  class Caesar
    class << self
# @param [String] sym
# @param [integer] key
def caesar_symbch(sym, key)
  upper_rus = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
  lower_rus = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
  if upper_rus.include?(sym)
    upper_rus[(upper_rus.index(sym) + key) % 33]
  elsif lower_rus.include?(sym)
    lower_rus[(lower_rus.index(sym) + key) % 33]
  elsif sym.ord in 65..90
    (((sym.ord - 65 + key) % 26) + 65).chr(Encoding::UTF_8)
  elsif sym.ord in 97..122
    (((sym.ord - 97 + key) % 26) + 97).chr(Encoding::UTF_8)
  elsif sym.ord in 48..57
    (((sym.ord - 48 + key) % 10) + 48).chr(Encoding::UTF_8)
  else
    sym
  end
end

# string encryption with Caesar cipher|Шифрование строки методом Цезаря
# @param str [String] input string|исходная строка
# @param key [Integer] amount to move|сдвиг
# @return [String] encrypted string|зашифрованная строка
def caesar_cipher(str, key)
  encstr = ''
  str.chars.each do |x|
    encstr += caesar_symbch(x, key)
  end
  encstr
end

# string decryption with Caesar cipher|Расшифровка строки методом Цезаря
# @param str [String] encrypted string|зашифрованная строка
# @param key [Integer] amount to move|сдвиг
# @return [String] decrypted string|исходная строка
def caesar_decipher(str, key)
  caesar_cipher(str, -key)
end
    end
  end
end

