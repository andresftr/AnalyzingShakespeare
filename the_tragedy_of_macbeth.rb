require 'nokogiri'
require 'open-uri'

class TheTragedyOfMacbethXml
  def download_xml
    doc = Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"))
  end

  def get_speeches
    doc = self.download_xml
    doc.xpath('//SPEECH').each { |speech| speech.at_xpath('SPEAKER').content }.to_a
  end

  def get_speakers
    doc = self.download_xml
    speakers = []
    doc.search('SPEECH').map { |speech| speakers << speech.search('SPEAKER').inner_text }
    speakers
  end

  def lines_by_speech
    doc = self.download_xml
    lines = []
    doc.search('SPEECH').map { |speech| lines << speech.search('LINE') }
    lines
  end

  def number_lines_spoken_by_all_characters
    speakers = self.get_speakers
    lines = self.lines_by_speech
    result = {}
    (0..648).each do |i|
      unless result.include?("#{speakers[i]}") || speakers[i] == "ALL"
        result["#{speakers[i]}"] = lines[i].size
      else
        unless speakers[i] == "ALL"
          result["#{speakers[i]}"] += lines[i].size
        end
      end
    end
    result
  end

  def n_lines_spoken_by_one_character(name_character)
    hash_characters = self.number_lines_spoken_by_all_characters
    number_lines = hash_characters[name_character]
    "The character #{name_character} #{ hash_characters.has_key?(name_character)? "speak #{number_lines} line(s)" : "doesnt exist" }"
  end
end

ttom = TheTragedyOfMacbethXml.new

ttom.number_lines_spoken_by_all_characters

puts ttom.n_lines_spoken_by_one_character("MACBETH")