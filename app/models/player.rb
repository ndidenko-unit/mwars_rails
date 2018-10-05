class Player < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :name, length: { maximum: 20 }
  has_many :battle_to_players
  has_many :battles, through: :battle_to_players
end
