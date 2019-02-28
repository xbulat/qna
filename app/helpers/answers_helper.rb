module AnswersHelper
  def best_answer_icon(answer)
    answer.best ? "trophy" : "comment"
  end
end
