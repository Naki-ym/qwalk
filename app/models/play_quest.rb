class PlayQuest < ApplicationRecord
  validates :user_id, {presence: true}
  validates :quest_id, {presence: true}
end
