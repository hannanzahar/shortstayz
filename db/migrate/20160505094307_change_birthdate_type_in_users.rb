class ChangeBirthdateTypeInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :birthdate, :string
  end
end
