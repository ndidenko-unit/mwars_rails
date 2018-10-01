class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :games, default: 0
      t.integer :victories, default: 0
      t.integer :losses, default: 0
      t.timestamps
    end
  end
end
