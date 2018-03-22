class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :ordered_by_title, -> { order( 'title DESC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }


#this allow posts to be organized by date
  default_scope { order('created_at DESC')}
  # makes comments dependent on posts existence
  # when posts are deleted the comments are deleted as well

  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
