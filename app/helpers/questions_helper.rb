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

  def owner_of?(question_object)
    session[:user_id] == question_object.user_id
  end
end
