class ParsingService

  def self.parse_and_save source_name
    data_source = DataSource.find_by_name source_name
    posts_from_source = data_source.posts
    parser_name = data_source.parser_name

    parsed_data = send("#{parser_name}_parser").parse
    parsed_data.each do |data|
      unless posts_from_source.find_by(posted_at: data[:posted_at], title: data[:title])
        posts_from_source.create(data)
      end
    end
  end

  private

  def self.ki_parser
    @ki_parser ||= KIParser.new
  end

 def self.iet_parser
   @iet_parser ||= IETParser.new
 end

 def self.sjo_parser
   @sjo_parser ||= SJOParser.new
 end

end
