class Quest < ApplicationRecord
  validates :title, {presence: true, length: {maximum: 30}}
  validates :caption, {presence: true, length: {maximum: 200}}
end
