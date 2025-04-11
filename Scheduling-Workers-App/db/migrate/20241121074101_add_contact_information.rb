class AddContactInformation < ActiveRecord::Migration[7.2]
  def change

    add_column :cleaners, :phone, :string
    add_column :cleaners, :email, :string
    add_column :cleaners, :hours_required, :integer

    add_column :sites, :phone, :string
    add_column :sites, :email, :string

  end
end
