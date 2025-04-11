class AddInteralNumberAndNotes < ActiveRecord::Migration[7.2]
  def change
  
    add_column :cleaners, :internaln, :integer
    add_column :jobs, :notes, :string

  end
end
