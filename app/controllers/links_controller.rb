class LinksController < ApplicationController
  before_action :authenticate_user!

  expose :links, -> { Link.find(params[:id]) }

  def destroy
    if current_user.author_of?(links.linkable)
      links.destroy

      url = links.linkable_type == 'Answer' ? links.linkable.question : links.linkable
      redirect_to question_path(url)
    else
      render plain: 'Forbidden', status: :forbidden
    end
  end
end
