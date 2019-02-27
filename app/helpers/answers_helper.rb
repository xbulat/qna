module AnswersHelper
  def best_answer_symbol(answer)
    answer.best ? "★" : "⚬"
  end
end
