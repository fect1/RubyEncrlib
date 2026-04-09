# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/encrlib/viginere'

class ViginereCipherTest < Minitest::Test
  def test_viginere_round_trip_for_english_text
    source = 'DefendTheEastWall'
    key = 'Fort'

    encrypted = Encrlib::Viginere.viginere_cipher(source, key)

    assert_equal source, Encrlib::Viginere.viginere_decipher(encrypted, key)
  end

  def test_viginere_round_trip_with_mixed_content
    source = 'Secret-42: meet at 19:30.'
    key = 'Key42'

    encrypted = Encrlib::Viginere.viginere_cipher(source, key)

    assert_equal source, Encrlib::Viginere.viginere_decipher(encrypted, key)
  end

  def test_viginere_supports_cyrillic_round_trip
    source = 'Текст 987'
    key = 'Ключ'

    encrypted = Encrlib::Viginere.viginere_cipher(source, key)

    assert_equal source, Encrlib::Viginere.viginere_decipher(encrypted, key)
  end

  def test_viginere_decrypts_russian_text
    encrypted = 'Ртжв, яьнф!'

    assert_equal 'Ёжик, беги!', Encrlib::Viginere.viginere_decipher(encrypted, 'Ключ')
  end

  def test_vigenere_round_trip
    original = 'Проверка связи 123!'
    key = 'Секрет'
    encrypted = Encrlib::Viginere.viginere_cipher(original, key)

    assert_equal original, Encrlib::Viginere.viginere_decipher(encrypted, key)
  end

  def test_vigenere_commutativity
    text = 'АЛГОРИТМ'
    key = 'МУЗЫКА'

    result_1 = Encrlib::Viginere.viginere_cipher(text, key)
    result_2 = Encrlib::Viginere.viginere_cipher(key, text)

    assert_equal result_1[0...key.length], result_2[0...key.length]
  end

  def test_viginere_decrypts_mixed_latin_and_cyrillic
    assert_equal 'AbcПрив', Encrlib::Viginere.viginere_decipher('KfaЪьжл', 'KeyКлю')
  end

  def test_viginere_lat_cyr_alphabet_decipher
    source = 'ТекстTextdifFerents 987'
    key = 'КлючCluch'

    encrypted = Encrlib::Viginere.viginere_cipher(source, key)

    assert_equal source, Encrlib::Viginere.viginere_decipher(encrypted, key)
  end
end