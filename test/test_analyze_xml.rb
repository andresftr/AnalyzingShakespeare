require 'minitest/autorun'
require './analyze_xml.rb'

class TestAnalyzeXml < Minitest::Test
  def analyze_xml
    @doc = AnalyzeXml.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
  end

  def test_num_lines_spoken_all
    test_1 = {"First Witch"=>62,
              "Second Witch"=>27,
              "Third Witch"=>27,
              "DUNCAN"=>70,
              "MALCOLM"=>212,
              "Sergeant"=>35,
              "LENNOX"=>73,
              "ROSS"=>135,
              "MACBETH"=>719,
              "BANQUO"=>113,
              "ANGUS"=>21,
              "LADY MACBETH"=>265,
              "Messenger"=>23,
              "FLEANCE"=>2,
              "Porter"=>46,
              "MACDUFF"=>180,
              "DONALBAIN"=>10,
              "Old Man"=>11,
              "ATTENDANT"=>1,
              "First Murderer"=>30,
              "Second Murderer"=>15,
              "Both Murderers"=>2,
              "Servant"=>5,
              "Third Murderer"=>8,
              "Lords"=>3,
              "HECATE"=>39,
              "Lord"=>21,
              "First Apparition"=>2,
              "Second Apparition"=>4,
              "Third Apparition"=>5,
              "LADY MACDUFF"=>41,
              "Son"=>20,
              "Doctor"=>45,
              "Gentlewoman"=>23,
              "MENTEITH"=>12,
              "CAITHNESS"=>11,
              "SEYTON"=>5,
              "SIWARD"=>30,
              "Soldiers"=>1,
              "YOUNG SIWARD"=>7
              }
    assert_equal test_1, analyze_xml.num_lines_spoken_all
  end

  def test_search_character_1
    test_2 = "The character MACBETH speak 719 line(s)"
    assert_equal test_2, analyze_xml.search_character("MACBETH")
  end

  def test_search_character_2
    test_3 = "The character LENNOX speak 73 line(s)"
    assert_equal test_3, analyze_xml.search_character("LENNOX")
  end

  def test_search_character_3
    test_4 = "The character MACBETH doesnt exist"
    refute_equal test_4, analyze_xml.search_character("MACBETH")
  end
end