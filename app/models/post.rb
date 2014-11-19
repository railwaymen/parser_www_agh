class Post < ActiveRecord::Base
  belongs_to :data_source
  validates :data_source, :title, :posted_at, :origin_url, presence: true
end
