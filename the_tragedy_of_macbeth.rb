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
    doc.search('SPEECH').map { |element| speakers << element.search('SPEAKER').inner_text }
    speakers
  end

  def lines_by_speech(speech_number)
    speeches = self.get_speeches
    lines = []
    speeches[speech_number].search('LINE').map do |line|
      lines << line.inner_text
    end
    lines.size
  end

  def lines_by_speech_2
    doc = self.download_xml
    lines = []
    doc.search('SPEECH').map { |element| lines << element.search('LINE') }
    lines
  end

  def ordened_speeches
    aux = ["ALL"]
    speakers = self.get_speakers
    resultado = []
    (0..648).each do |i|
      puts "#{speakers[i]} - #{self.lines_by_speech(i)}"
    end
  end
end

ttom = TheTragedyOfMacbethXml.new

speakers = ttom.get_speakers
speeches = ttom.get_speeches

# puts speakers
puts ttom.lines_by_speech_2.size
# puts ttom.ordened_speeches

# puts ttom.ordened_speeches