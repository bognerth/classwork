class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :description
      t.integer :course_id
      t.integer :category_id
      t.integer :duration

      t.timestamps
    end
  end
end
