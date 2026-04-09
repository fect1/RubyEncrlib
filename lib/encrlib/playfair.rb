# frozen_string_literal: true

def ch_search(key)
  upper_rus = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
  lower_rus = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
  upper_eng = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  lower_eng = 'abcdefghijklmnopqrstuvwxyz'
  ch = ''
  if upper_rus.include? key[0][0]
    ch = 'Х'
  elsif lower_rus.include? key[0][0]
    ch = 'х'
  elsif upper_eng.include? key[0][0]
    ch = 'X'
  elsif lower_eng.include? key[0][0]
    ch = 'sym'
  end
  ch
end

module Encrlib
  class Playfair
    class << self
def xy_selector; end

# string encryption with Playfair cipher/Шифрование строки методом Плейфера
# @param str [String] input string|исходная строка
# @param key [Array<Array<String>>] square matrix as key|ключ в виде квадратной матрицы
# @return [String] encrypted string|зашифрованная строка
def playfair_cipher(str, key)
  ch = ch_search(key)
  ind = 0
  encstr = ''
  str = str.delete(' ')
  while ind < str.size
    x1 = -2
    y1 = -2
    x2 = -2
    y2 = -2
    (0..(key.size - 1)).each do |i|
      (0..(key.size - 1)).each do |j|
        if str[ind] == key[i][j]
          x1 = i
          y1 = j
        end
        if str[ind + 1] == key[i][j]
          x2 = i
          y2 = j
        end
      end
    end
    if x2 == -2 && y2 == -2 && x1 != -2 && y1 != -2
      str += ch
      redo
    end
    if x1 == x2 && y1 == y2
      str = "#{str[0..ind]}#{ch}#{str[(ind + 1)..]}"
      ind -= 2
    else
      encstr += if x1 != x2 && y1 != y2
                  key[x1][y2] + key[x2][y1]
                elsif x1 != x2 && y1 == y2
                  x1 = -1 if x1 + 1 > key.size - 1
                  x2 = -1 if x2 + 1 > key.size - 1
                  key[x1 + 1][y1] + key[x2 + 1][y2]
                else
                  y1 = -1 if y1 + 1 > key[x1].size - 1
                  y2 = -1 if y2 + 1 > key[x2].size - 1
                  key[x1][y1 + 1] + key[x2][y2 + 1]
                end
    end
    ind += 2
  end
  encstr
end

# string decryption with Playfair cipher|Расшифровка строки методом Плейфера
# @param str [String] encrypted string|зашифрованная строка
# @param key [Array<Array<String>>] square matrix as key|ключ в виде квадратной матрицы
# @return [String] decrypted string|исходная строка
def playfair_decipher(str, key)
  ch = ch_search(key)
  ind = 0
  encstr = ''
  str = str.delete(' ')
  while ind < str.size
    x1 = key.size + 1
    y1 = key.size + 1
    x2 = key.size + 1
    y2 = key.size + 1
    (0..(key.size - 1)).each do |i|
      (0..(key.size - 1)).each do |j|
        if str[ind] == key[i][j]
          x1 = i
          y1 = j
        end
        if str[ind + 1] == key[i][j]
          x2 = i
          y2 = j
        end
      end
    end
    encstr += if x1 != x2 && y1 != y2
                key[x1][y2] + key[x2][y1]
              elsif x1 != x2 && y1 == y2
                x1 = 5 if x1.zero?
                x2 = 5 if x2.zero?
                key[x1 - 1][y1] + key[x2 - 1][y2]
              else
                y1 = 5 if y1.zero?
                y2 = 5 if y2.zero?
                key[x1][y1 - 1] + key[x2][y2 - 1]
              end
    ind += 2
  end
  encstr = encstr[0..-2] if encstr[-1] == ch
  x = 0
  while x < encstr.size - 3
    encstr = encstr[0..x] + encstr[(x + 2)..] if encstr[x] == encstr[x + 2] && encstr[x + 1] == ch
    x += 1
  end
  encstr
end
    end
  end
end
