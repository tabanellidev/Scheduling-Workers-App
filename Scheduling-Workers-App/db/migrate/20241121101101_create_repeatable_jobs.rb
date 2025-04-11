class CreateRepeatableJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :repeatable_jobs do |t|
      
      t.integer :day
      t.string :hour
      t.float :duration

      t.belongs_to :cleaner, null: false, foreign_key: true
      t.belongs_to :site, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
