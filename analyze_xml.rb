require 'nokogiri'
require 'open-uri'

class AnalyzeXml
def initialize(doc)
  @doc ||= Nokogiri::XML(open(doc))
end

  private
    def speakers
      @speakers ||= @doc.search('SPEECH').map { |speech| speech.at_xpath('SPEAKER').content }
    end

    def lines
      @lines ||= @doc.search('SPEECH').map { |speech| speech.search('LINE') }
    end

  public
    def num_lines_spoken_all
      result = {}
      length = speakers.size
      (0..length-1).each do |i| 
        if !result.include?("#{speakers[i]}") && speakers[i] != "ALL"
          result["#{speakers[i]}"] = lines[i].size
        elsif speakers[i] != "ALL"
          result["#{speakers[i]}"] += lines[i].size
        end
      end
      result
    end

    def search_character(name_character)
      hash_characters = num_lines_spoken_all
      number_lines = hash_characters[name_character]
      "The character #{name_character} #{ hash_characters.has_key?(name_character)? "speak #{number_lines} line(s)" : "doesnt exist" }"
    end
end