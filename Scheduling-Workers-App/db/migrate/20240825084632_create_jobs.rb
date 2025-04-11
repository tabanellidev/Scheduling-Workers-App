class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.datetime :date
      t.float :duration
      t.timestamps

      t.belongs_to :cleaner, null: false, foreign_key: true
      t.belongs_to :site, null: false, foreign_key: true

    end

  end
end
