class Like < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  # one like per user per dog?
  validates :user_id, uniqueness: { scope: :dog_id} 
end