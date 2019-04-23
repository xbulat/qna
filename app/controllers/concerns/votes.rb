module Votes
  extend ActiveSupport::Concern

  included do
    before_action :get_model, only: [:like, :dislike, :revoke]
  end

  def like
    unless current_user.author_of?(@voted)
      @voted.rating_up(current_user)
      render_json
    end
  end

  def dislike
    unless current_user.author_of?(@voted)
      @voted.rating_down(current_user)
      render_json
    end
  end

  def revoke
    @voted.revoke_vote(current_user)
    render_json
  end

  private

  def render_json
    render json: { score: @voted.rating.score, klass: @voted.class.to_s.underscore, id: @voted.id }
  end

  def model_klass
    controller_name.classify.constantize
  end

  def get_model
    @voted = model_klass.find(params[:id])
  end
end
