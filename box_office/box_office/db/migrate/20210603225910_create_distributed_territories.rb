class CreateDistributedTerritories < ActiveRecord::Migration[5.2]
  def change
    create_table :distributed_territories do |t|
      t.integer :distributor_id, null: false
      t.integer :territory_id, null: false
      t.integer :film_id, null: false

      t.timestamps
      t.index :film_id
      t.index :territory_id
      t.index :distributor_id
      t.index [:distributor_id, :territory_id, :film_id], unique: true, name: 'dist_terrs_index'
    end
  end
end
