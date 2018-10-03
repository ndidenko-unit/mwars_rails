class Battle < ApplicationRecord
  validates :left_player, :right_player, presence: true
  has_many :battle_to_players
  has_many :players, through: :battle_to_players
end
