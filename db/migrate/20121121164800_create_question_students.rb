class CreateQuestionStudents < ActiveRecord::Migration
  def change
    create_table :answer_students do |t|
      t.integer :answer_id
      t.integer :student_id
      t.integer :test_id
      t.integer :test_student_id
      t.integer :question_id
      t.integer :points
      t.timestamps
    end
  end
end
