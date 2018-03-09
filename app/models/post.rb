class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  # makes comments dependent on posts existence
  # when posts are deleted the comments are deleted as well
end
