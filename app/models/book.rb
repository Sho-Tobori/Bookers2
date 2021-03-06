class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length:{ maximum: 20 }

	belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reservations

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


end
