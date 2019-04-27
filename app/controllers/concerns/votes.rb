module Votes
  extend ActiveSupport::Concern

  included do
    before_action :get_model, only: [:like, :dislike, :revoke]
  end

  def like
    unless current_user.author_of?(@voted)
      @voted.ratings.create!(user: current_user, score: 1)
      render_json
    else
      render plain: 'Forbidden', status: :forbidden
    end
  end

  def dislike
    unless current_user.author_of?(@voted)
      @voted.ratings.create!(user: current_user, score: -1)
      render_json
    else
      render plain: 'Forbidden', status: :forbidden
    end
  end

  def revoke
    @voted.revoke_vote(current_user)
    render_json
  end

  private

  def render_json
    render json: { score: @voted.current_rating, klass: @voted.class.to_s.underscore, id: @voted.id }
  end

  def model_klass
    controller_name.classify.constantize
  end

  def get_model
    @voted = model_klass.find(params[:id])
  end
end
