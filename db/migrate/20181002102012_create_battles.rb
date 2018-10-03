class CreateBattles < ActiveRecord::Migration[5.2]
  def change
    create_table :battles do |t|
      t.string  :left_player
      t.string  :right_player
      t.integer :left_scores, default: 100
      t.integer :right_scores, default: 100
      t.integer :turn, default: 2
      t.timestamps
    end
  end
end
