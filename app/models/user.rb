class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}

  def quests
    return Quest.where(user_id: self.id, publish: true)
  end
end
