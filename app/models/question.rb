class Question < ActiveRecord::Base
  attr_accessible :category_id, :status, :text, :answers_attributes

  has_many :answers
  has_many :answer_students
  belongs_to :category

	accepts_nested_attributes_for :answers, allow_destroy: true
  #named_scope :previous, lambda { |p| {:conditions => ["id < ?", p.id], :limit => 1, :order => "id"} }
	#named_scope :next, lambda { |p| {:conditions => ["id > ?", p.id], :limit => 1, :order => "id"} }
end	
