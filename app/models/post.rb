class Post < ActiveRecord::Base
  belongs_to :data_source
  validates :data_source, :title, :posted_at, :origin_url, presence: true

  def serializable_hash(options = {})
    super(only: [:title, :content, :posted_at, :origin_url])
  end
end
