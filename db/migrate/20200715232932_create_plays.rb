class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.integer :timer_value
      t.references :image

      t.timestamps
    end
  end
end
