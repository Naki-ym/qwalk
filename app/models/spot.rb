class Spot < ApplicationRecord
  validates :quest_id, {presence: true}
  validates :q_text, {presence: true, length: {maximum: 500}}
  validates :answer, {presence: true, length: {maximum: 30}}
  validates :a_text, {presence: true, length: {maximum: 500}}
end
