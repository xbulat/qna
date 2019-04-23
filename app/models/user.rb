class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :answers
  has_many :badges
  has_many :votes

  def author_of?(object)
    object.user_id == id
  end

  def my_vote(object)
    object.rating.votes.find_by(user: self)
  end
end
