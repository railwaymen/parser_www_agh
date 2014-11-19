class DataSource < ActiveRecord::Base
  has_many :posts
  validates :name, :parser_name, presence: true
end
