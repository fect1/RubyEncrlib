# frozen_string_literal: true

module Encrlib
  class RailFence
    class << self
      # @param [Integer] length
      # @param [Integer] key
      def build_pattern(length, key)
        pattern = []
        rail = 0
        direction = 1

        length.times do
          pattern << rail

          direction = 1 if rail.zero?
          direction = -1 if rail == key - 1
          rail += direction
        end

        pattern
      end

      # @param [Array] pattern
      # @param [Integer] key
      def rail_lengths_from_pattern(pattern, key)
        lengths = Array.new(key, 0)
        pattern.each { |i| lengths[i] += 1 }
        lengths
      end

      # string encryption with Rail Fence cipher|Шифрование строки методом Железнодорожной изгороди
      # @param str [String] input string|исходная строка
      # @param key [Integer] rails count|количество рельс
      # @return [String] encrypted string|зашифрованная строка
      def cipher(str, key)
        return str if key <= 1 || str.size <= 1

        pattern = build_pattern(str.size, key)
        rails = Array.new(key) { '' }

        str.each_char.with_index do |ch, i|
          rails[pattern[i]] += ch
        end

        rails.join
      end

      # string decryption with Rail Fence cipher|Расшифровка строки методом Железнодорожной изгороди
      # @param str [String] encrypted string|зашифрованная строка
      # @param key [Integer] rails count|количество рельс
      # @return [String] decrypted string|исходная строка
      def decipher(str, key)
        return str if key <= 1 || str.size <= 1

        pattern = build_pattern(str.size, key)
        rail_lengths = rail_lengths_from_pattern(pattern, key)

        rails = []
        cursor = 0

        rail_lengths.each do |len|
          rails << str[cursor, len].chars
          cursor += len
        end

        rail_positions = Array.new(key, 0)
        result = ''

        pattern.each do |idx|
          result += rails[idx][rail_positions[idx]]
          rail_positions[idx] += 1
        end

        result
      end
    end
  end
end