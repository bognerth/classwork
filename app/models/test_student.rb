class TestStudent < ActiveRecord::Base
  attr_accessible :end, :points, :start, :student_id, :test_id, :current_question_id, :count_questions

  belongs_to :student 
  belongs_to :test 
  has_many :answer_students, :dependent => :destroy
  
  def test_exists(user_id)

  end
end
