class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]

    if @answer.save
      redirect_to @answer.question, notice: 'Answer was successfully created.'
    else
      @question = Question.find(params[:question_id])
      render "questions/show"
    end
  end

  def update
    Answer.where(question_id: params[:question_id]).update_all(best: false)
    Answer.find(params[:id]).update(best: true)
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    redirect_to @question
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:description)
  end
end
