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

  def lines_by_speech
    doc = self.download_xml
    lines = []
    doc.search('SPEECH').map { |element| lines << element.search('LINE') }
    lines
  end

  def ordened_speeches
    speakers = self.get_speakers
    lines = self.lines_by_speech
    result = {}
    (0..648).each do |i|
      unless result.include?("#{speakers[i]}") || speakers[i] == "ALL"
        result["#{speakers[i]}"] = lines[i].size
      else
        # sumar los valores
      end
    end
    result
  end
end

ttom = TheTragedyOfMacbethXml.new

speakers = ttom.get_speakers
speeches = ttom.get_speeches

# puts speakers
# puts ttom.lines_by_speech
puts ttom.ordened_speeches

# puts ttom.ordened_speeches