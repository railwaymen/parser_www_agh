class DataSource < ActiveRecord::Base
  has_many :posts
  validates :name, :parser_name, presence: true

  def serializable_hash(options = {})
    super(only: [:id, :name])
  end
end
