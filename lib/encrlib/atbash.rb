# frozen_string_literal: true

module Encrlib
  class Atbash
    class << self
      # @param [String] sym
      def atbash_symbch(sym)
        upper_rus = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
        lower_rus = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
        upper_eng = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        lower_eng = 'abcdefghijklmnopqrstuvwxyz'

        if (idx = upper_rus.index(sym))
          upper_rus[-1 - idx]
        elsif (idx = lower_rus.index(sym))
          lower_rus[-1 - idx]
        elsif (idx = upper_eng.index(sym))
          upper_eng[-1 - idx]
        elsif (idx = lower_eng.index(sym))
          lower_eng[-1 - idx]
        else
          sym
        end
      end

      # string encryption with Atbash cipher|шифрование строки шифром Атбаш
      # @param str [String] input string|исходная строка
      # @return [String] encrypted string|зашифрованная строка
      def atbash_cipher(str)
        str.each_char.map { |ch| atbash_symbch(ch) }.join
      end
    end
  end
end