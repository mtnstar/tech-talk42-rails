class CreatePeaks < ActiveRecord::Migration[8.0]
  def change
    create_table :peaks do |t|
      t.string :name
      t.integer :altitude

      t.timestamps
    end
  end
end
