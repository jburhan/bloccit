class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  # makes comments dependent on posts existence
  # when posts are deleted the comments are deleted as well

  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
end
