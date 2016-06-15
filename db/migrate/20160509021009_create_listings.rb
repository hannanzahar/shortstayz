class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :country
      t.string :state
      t.string :city
      t.string :address
      t.string :property_type
      t.string :room_type
      t.string :num_people
      t.string :num_bedrooms
      t.string :num_beds
      t.string :num_bathrooms

      t.timestamps null: false
    end
  end
end
