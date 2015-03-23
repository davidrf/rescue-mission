class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates :title, length: { minimum: 40 }
  validates :description, length: { minimum: 150 }
end
