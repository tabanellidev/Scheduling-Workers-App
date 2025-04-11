class CreateSites < ActiveRecord::Migration[7.2]
  def change
    create_table :sites do |t|
      t.string :nome
      t.integer :time_required
      t.string :location
      t.text :requests
      t.string :owner

      t.timestamps
    end
  end
end
