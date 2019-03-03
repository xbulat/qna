class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  expose :attachment, -> { ActiveStorage::Attachment.find(params[:id]) }

  def destroy
    if current_user.author_of?(attachment.record)
      attachment.purge

      url = attachment.record_type == 'Answer' ? attachment.record.question : attachment.record
      redirect_to question_path(url)
    else
      render plain: 'Forbidden', status: :forbidden
    end
  end
end
