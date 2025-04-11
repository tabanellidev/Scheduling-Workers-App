class AddMonthAndYearToSchedule < ActiveRecord::Migration[7.2]
  def change
  
    add_column :repeatable_jobs, :date, :datetime
    
  end
end
