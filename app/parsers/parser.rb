class Parser
  require 'open-uri'

  def parse
    raise NoMethodError
  end

  protected

  def strip_line_breaks_and_join nodeset
    nodeset.map{ |node| node.text.gsub(/\r*\n+/, ' ').strip }.join
  end
end
