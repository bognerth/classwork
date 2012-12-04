class Test < ActiveRecord::Base
    attr_accessible :category_id, :course_id, :description, :duration

    has_many :test_students
    belongs_to :course 
    belongs_to :category

    has_many :events, class_name: "TestEvent"

    STATES = %w[new open canceled shipped closed]
    delegate :new?, :open?, :canceled?, :shipped?, :closed?, to: :current_state

    def self.open_tests
      joins(:events).merge TestEvent.with_last_state("open")
    end

    def current_state
      (events.last.try(:state) || STATES.first).inquiry
    end

    def purchase(valid_payment = true)
      if new?
        # process purchase ...
        events.create! state: "open" if valid_payment
      end
    end

    def change(state)
      events.create! state: state
    end

    def resume
      events.create! state: "open" if canceled?
    end

    def ship
      events.create! state: "shipped" if open?
    end

end
