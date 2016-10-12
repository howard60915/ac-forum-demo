class CreateUbikeStations < ActiveRecord::Migration[5.0]
  def change
    create_table :ubike_stations do |t|
      t.string :iid
      t.string :roadmark
      t.string :area
      t.string :number_of_bike
      t.timestamps
    end
  end
end
