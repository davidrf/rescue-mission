class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]

    if @answer.save
      redirect_to @answer.question, notice: 'Question was successfully created.'
    else
      redirect_to @answer.question
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:description)
  end
end
