class Student < ActiveRecord::Base
  attr_accessible :group_id, :user_id

  has_many :answer_students
  has_many :test_students
  belongs_to :group 
  belongs_to :user
end
