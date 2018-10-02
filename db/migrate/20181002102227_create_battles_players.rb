class CreateBattlesPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :battles_players, id: false do |t|
      t.integer :battle_id
      t.integer :player_id
    end
  end
end
