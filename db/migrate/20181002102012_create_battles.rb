class CreateBattles < ActiveRecord::Migration[5.2]
  def change
    create_table  :battles do |t|
      t.string    :left_player
      t.string    :right_player
      t.integer   :left_scores,   default: 100
      t.integer   :right_scores,  default: 100
      t.integer   :turn,          default: nil
      t.string    :example,       default: nil
      t.integer   :result,        default: nil
      t.integer   :answer,        default: nil
      t.integer   :wound,         default: nil
      t.integer   :start_kick,    default: nil
      t.integer   :seconds,       default: nil
      t.boolean   :hit,           default: false
      t.timestamps
    end
  end
end
