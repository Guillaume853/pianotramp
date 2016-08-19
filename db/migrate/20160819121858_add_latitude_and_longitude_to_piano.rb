class AddLatitudeAndLongitudeToPiano < ActiveRecord::Migration[5.0]
  def change
    add_column :pianos, :latitude, :float
    add_column :pianos, :longitude, :float
  end
end
