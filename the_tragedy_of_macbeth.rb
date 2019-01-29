require 'nokogiri'
require 'open-uri'

class TheTragedyOfMacbethXml
  def download_xml
    doc = Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"))
  end

  def get_speakers
    xml_play = self.download_xml
    speakers = []
    xml_play.search('SPEECH').map do |element|
      speakers << element.search('SPEAKER').inner_text
    end
    speakers
  end

  def get_speeches(xml)
    xml_play = xml.download_xml
    xml_play.xpath('//SPEECH').each { |speech| speech.at_xpath('SPEAKER').content }.to_a
  end

  def lines_of_nodeset(speechs)
    speechs
  end
end

ttom = TheTragedyOfMacbethXml.new

speakers = ttom.get_speakers

puts speakers.size

# i = 0
# speakers_sin_repetir = ["ALL"]
# speakers.each do |speaker|
#   unless speakers_sin_repetir.include? speaker
#     i += 1
#     puts "#{i} - #{speaker}"
#     speakers_sin_repetir << speaker
#   end
# end

# puts speeches = ttom.get_speeches(ttom)[29]

# puts ttom.numbers_of_lines(speechs, ttom)