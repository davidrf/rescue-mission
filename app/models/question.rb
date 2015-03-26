class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, length: { minimum: 40 }
  validates :description, length: { minimum: 150 }
  validates_presence_of :user, message: "Please sign in"
end
