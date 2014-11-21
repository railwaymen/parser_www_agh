require 'open-uri'

class Parser
  def parse
    raise NoMethodError
  end

  private

  def strip_line_breaks(node)
    node.text.gsub(/[\r\n\t]/, ' ').strip
  end
end
