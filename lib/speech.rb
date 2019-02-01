require './analyze_xml.rb'

class Speech < AnalyzeXml
  @doc = AnalyzeXml.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")

  def speakers
    @speakers ||= @doc.search('SPEECH').map { |speech| speech.at_xpath('SPEAKER').content }
  end

  def lines
    @lines ||= @doc.search('SPEECH').map { |speech| speech.search('LINE') }
  end
end