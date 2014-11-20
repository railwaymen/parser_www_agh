class IETParser < Parser

  BASE_PARSING_URL = 'http://www.iet.agh.edu.pl/pl/aktualnosci/'.freeze

  def initialize
    @url = BASE_PARSING_URL
  end

  def parse
    page = Nokogiri::HTML(open @url)
    news_links = page.css 'div.accordion-item a'
    date_class = get_date_class_from_element news_links.first
    if date_class
      news_links.map do |link|
        {
          posted_at: link.css(".#{date_class}").text,
          title: get_news_header_from_link(link),
	  origin_url: link['href'],
          content: get_full_news_text_from_link(link)
        }
      end
    end
  end

  private

  def get_date_class_from_element el
    el.children.each do |child_el|
      css_class_attr = child_el.attributes['class']
      if css_class_attr
        css_class = css_class_attr.value
        return css_class if css_class.match /date/i
      end
    end
  end

  def get_news_header_from_link link
    text_nodes = link.children.select do |node|
                   node.text? && node.text.strip.present?
                 end
    text_nodes.map{ |node| node.text.strip }.join
  end

  def get_full_news_text_from_link link
    href = link['href']
    page_with_open_news = Nokogiri::HTML(open href)
    content = page_with_open_news.css('h3.nav-selected').first
                                 .parent.css 'div.accordion-pane p'
    strip_line_breaks_and_join content
  end
end
