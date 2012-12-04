class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :tests
  has_many :questions
end
