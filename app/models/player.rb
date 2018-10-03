class Player < ApplicationRecord
  validates :name, presence: true
  has_many :battle_to_players
  has_many :battles, through: :battle_to_players
end
