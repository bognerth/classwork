class TestEvent < ActiveRecord::Migration
  def change
  	create_table :test_events do |t|
	  	t.belongs_to :test
	  	t.string :state
  		t.timestamps
		end
  end


end
