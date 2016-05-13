class AddColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :user_id, :integer
    add_column :reservations, :listing_id, :integer
    add_column :reservations, :check_in, :date
    add_column :reservations, :check_out, :date
  end
end
