class Battle < ApplicationRecord
  validates :left_player, :right_player, presence: true
  validates :left_player, length: { minimum: 2 }
  validates :left_player, length: { maximum: 20 }
  validates :right_player, length: { minimum: 2}
  validates :right_player, length: { maximum: 20}
  has_many :battle_to_players
  has_many :players, through: :battle_to_players
end
