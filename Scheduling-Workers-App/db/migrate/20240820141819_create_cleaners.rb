class CreateCleaners < ActiveRecord::Migration[7.2]
  def change
    create_table :cleaners do |t|
      t.string :name
      t.string :surname
      t.string :codfis
      t.string :residence
      t.string :license
      t.date :birthdate
      t.date :hired

      t.timestamps
    end
  end
end
