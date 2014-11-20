class SJOParser < Parser

  BASE_PARSING_URL = 'http://home.agh.edu.pl/~sjo/'.freeze

  def initialize
    @url = BASE_PARSING_URL
  end

  def parse
    news_data = get_news_data_from_page
    news_data.collect do |news_array|
      {
        posted_at: news_array[0],
        title: news_array[1],
	origin_url: news_array[2],
        content: get_content_from_url(news_array[2])
      }
    end
  end

  private

  def get_news_data_from_page
    page = Nokogiri::HTML(open @url)
    news_list = page.css '#newsmain ul'
    dates = news_list.css('em').map(&:text)
    links = news_list.css 'a'
    urls = links.map{ |link| link['href'] }
    titles = links.map(&:text)
    dates.zip titles, urls
  end

  def get_content_from_url url
    page = Nokogiri::HTML(open url)
    text_nodes = page.css('.text').children
    content = text_nodes.reject do |node|
                node.name.match /h4|em/ ||
                node['class'] == 'more'
              end
    strip_line_breaks_and_join content
  end

end
