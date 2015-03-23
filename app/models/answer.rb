class Answer < ActiveRecord::Base
  belongs_to :answer

  validates :title, length: { minimum: 50 }
  validates_presence_of :question
end
