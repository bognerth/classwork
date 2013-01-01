class ChangeStatusQuestions < ActiveRecord::Migration
  def change
		change_column :questions, :status, :boolean, :default => true
  end
end
