class TestEvent < ActiveRecord::Base
  belongs_to :test
  attr_accessible :state, :test_id

  validates_presence_of :test_id
  validates_inclusion_of :state, in: Test::STATES

  def self.with_last_state(state)
    order("id desc").group("test_id").where(state: state)
  end
end

