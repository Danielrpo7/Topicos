class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :tittle
      t.text :description
      t.boolean :private
      t.string :filesize

      t.timestamps
    end
  end
end
