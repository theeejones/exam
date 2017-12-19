class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :desc
      t.integer :creator

      t.timestamps null: false
    end
  end
end
