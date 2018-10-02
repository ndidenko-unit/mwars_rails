class Battle < ApplicationRecord
  validates :left_player, :right_player, presence: true
  has_and_belongs_to_many :players


end
