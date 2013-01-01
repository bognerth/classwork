class ChangeColumnPointsFromAnswers < ActiveRecord::Migration
  def change
		change_column :answers, :points, :integer, :default => 0
  end
end
