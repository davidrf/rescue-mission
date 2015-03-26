class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :update]

  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = @question.id

    if @answer.save
      redirect_to question_url(@question), notice: 'Answer was successfully created.'
    else
      render "questions/show"
    end
  end

  def update
    Answer.where(question_id: params[:question_id]).update_all(best: false)
    Answer.find(params[:id]).update(best: true)
    @answer = Answer.new
    redirect_to question_url(@question)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:description)
  end
end
