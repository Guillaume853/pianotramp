class CreatePianos < ActiveRecord::Migration[5.0]
  def change
    create_table :pianos do |t|
      t.string :brand
      t.string :address

      t.timestamps
    end
  end
end
