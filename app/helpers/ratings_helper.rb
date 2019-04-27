module RatingsHelper
  def show_rating_result(object)
    "<i class=\"score\">Score: #{object.current_rating}</i>"
  end

  def hide_voted(object)
    "hidden" if object.voted_of?(current_user)
  end
end
