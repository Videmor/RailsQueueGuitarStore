class CreateGuitars < ActiveRecord::Migration
  def change
    create_table :guitars do |t|
      t.string :model
      t.integer :year

      t.timestamps
    end
  end
end
