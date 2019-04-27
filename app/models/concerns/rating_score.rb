module RatingScore
  extend ActiveSupport::Concern
  included do
    has_many :ratings, dependent: :destroy, as: :linkable
  end

  def revoke_vote(user)
    ratings.where(user: user).delete_all
  end

  def voted_of?(user)
    ratings.exists?(user: user)
  end

  def likes
    ratings.where(score: "1").count
  end

  def dislikes
    ratings.where(score: "-1").count
  end

  def current_rating
    ratings.sum(:score)
  end
end
