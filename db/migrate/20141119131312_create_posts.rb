class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :data_source, index: true
      t.text :title
      t.text :content
      t.string :origin_url
      t.datetime :posted_at

      t.timestamps
    end

    add_index :posts, [:title, :posted_at]
  end
end
