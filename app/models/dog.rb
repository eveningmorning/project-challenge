class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user, optional: true
  has_many :likes

  def recent_likes 
    likes.where(created_at: 1.hour.ago..Time.now).count
  end
end
