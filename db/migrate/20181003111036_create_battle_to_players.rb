class CreateBattleToPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_to_players do |t|
      t.references :battle, foreign_key: true
      t.references :player, foreign_key: true
    end
  end
end
