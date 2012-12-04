class CreateCurrentSessions < ActiveRecord::Migration
  def change
    create_table :current_sessions do |t|
      t.integer :user_id
      t.integer :student_id
      t.integer :group_id
      t.text    :courses
      t.text    :tests
      t.string :email
      t.string :name
      t.string :state
      t.integer :c_test_id
      t.integer :c_category_id
      t.datetime :c_start
      t.integer :c_duration
      t.integer :c_test_student_id
      t.integer :c_count_questions
      t.timestamps
    end
  end
end
