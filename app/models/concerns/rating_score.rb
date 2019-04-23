module RatingScore
  extend ActiveSupport::Concern
  included do
    has_one :rating, dependent: :destroy, as: :linkable

    before_save :create_object_rating
  end

  def create_object_rating
    self.rating = Rating.new if self.rating.nil?
  end

  def rating_up(user)
    transaction do
      rating.increment(:score).save!
      rating.votes.create!(user: user, like: true )
    end
  end

  def rating_down(user)
    transaction do
      rating.decrement(:score).save!
      rating.votes.create!(user: user, like: false )
    end
  end

  def revoke_vote(user)
    user.my_vote(self).like == true ? rating_down(user) : rating_up(user)
    rating.votes.where(user: user).delete_all
  end

  def voted_of?(user)
    rating.votes.exists?(user: user)
  end
end
