require 'nokogiri'
require 'open-uri'

class TheTragedyOfMacbethXml
  def download_xml
    doc = Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"))
  end

  def get_speechs(xml)
    xml_play = xml.download_xml
    xml_play.xpath('//SPEECH').each { |speech| speech.at_xpath('SPEAKER').content }
  end

  def numbers_of_lines(speakers, xml)
    xml_play = xml.download_xml

    speakers.each do |speaker|
      puts speaker
    end
  end
end

ttom = TheTragedyOfMacbethXml.new

speechs = ttom.get_speechs(ttom)

puts speechs

# ttom.numbers_of_lines(speakers, ttom)