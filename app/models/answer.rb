class Answer < ActiveRecord::Base
  attr_accessible :points, :question_id, :text

  belongs_to :question
  has_many :answer_students
end
