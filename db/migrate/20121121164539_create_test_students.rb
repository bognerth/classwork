class CreateTestStudents < ActiveRecord::Migration
  def change
    create_table :test_students do |t|
      t.integer :test_id
      t.integer :student_id
      t.integer :points
      t.integer :current_question_id
      t.integer :count_questions
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
