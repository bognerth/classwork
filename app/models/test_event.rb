class TestEvent < ActiveRecord::Base
  belongs_to :test
  attr_accessible :state, :test_id

  validates_presence_of :test_id
  validates_inclusion_of :state, in: Test::STATES

  def self.with_last_state(state)
    order("id desc").group("test_id").where(state: state)
    #order("id desc").group("test_id").having(state: state) ---- gibt bei mysql einen Fehler 
		#SELECT `tests`.* FROM `tests` INNER JOIN `test_events` ON `test_events`.`test_id` = `tests`.`id` GROUP BY test_events.test_id HAVING `test_events`.`state` = 'open' ORDER BY tests.id desc;
    #Aenderung:
    #SELECT `tests`.*, test_events.* FROM `tests` INNER JOIN `test_events` ON `test_events`.`test_id` = `tests`.`id` GROUP BY test_events.test_id HAVING `test_events`.`state` = 'open' ORDER BY tests.id desc;
    
  end
end

