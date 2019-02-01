require 'nokogiri'
require 'open-uri'

class AnalyzeXml
  def initialize(url)
    @doc = Nokogiri::XML(open(url))
  end

  def acts
    @acts ||= @doc.search('ACT').map { |act| act.search('SPEECH') } 
  end

  def num_lines_spoken_all
    result = {}
    speakers.each.with_index do |speaker, i| 
      if !result.include?("#{speaker}") && speaker != "ALL"
        result["#{speaker}"] = lines[i].size
      elsif speakers[i] != "ALL"
        result["#{speaker}"] += lines[i].size
      end
    end
    result
  end

  def search_character(name_character)
    hash_characters = num_lines_spoken_all
    number_lines = hash_characters[name_character]
    "The character #{name_character} #{ hash_characters.has_key?(name_character)? "speak #{number_lines} line(s)" : "doesnt exist" }"
  end

  private

  def speakers
    @speakers ||= @doc.search('SPEECH').map { |speech| speech.at_xpath('SPEAKER').content }
  end

  def lines
    @lines ||= @doc.search('SPEECH').map { |speech| speech.search('LINE') }
  end
end

xml = AnalyzeXml.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")

puts xml.acts[1].each { |act| act.search('SPEECH') }[4]