class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :gender, :string
  	add_column :users, :birthdate, :integer
  	add_column :users, :phone_num, :integer
  	add_column :users, :address, :string
  	add_column :users, :subscribe, :boolean
  end 
end
