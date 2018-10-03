class BattleToPlayer < ApplicationRecord
  belongs_to :battle
  belongs_to :player
end
