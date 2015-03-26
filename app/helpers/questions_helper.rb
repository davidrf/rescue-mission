module QuestionsHelper
  def sort_answers_for(question_object)
    answers = []
    best_answer = nil
    question_object.answers.each do |answer|
      if answer.best
        best_answer = answer
      else
        answers << answer
      end
    end
    answers.unshift(best_answer) if best_answer
    answers
  end
end
