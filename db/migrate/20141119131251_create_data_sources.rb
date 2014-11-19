class CreateDataSources < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name
      t.string :parser_name

      t.timestamps
    end
  end
end
