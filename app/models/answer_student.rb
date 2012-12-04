class AnswerStudent < ActiveRecord::Base
  attr_accessible :answer_id, :student_id, :test_id, :test_student_id, :question_id, :points

  belongs_to :answer
  belongs_to :student
  belongs_to :test 
  belongs_to :question
  belongs_to :test_student

  def self.first_or_create_and_update(answer_id, student_id, test_id)

		#person = Person.find_by_name(name) || Person.new(:name => name)
		#person.update_attributes!(:s
  end
end
