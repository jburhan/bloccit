class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  #before_save allows us to register an inline callback
  before_save { self.email = email.downcase if email.present? }
  before_save {
    array = []
    name.to_s.split.each do |n|
      array.push(n.capitalize)
    end
    self.name = array.join(" ")
   }

# ||= is a ruby trick.
  before_save { self.role ||= :member}
# this is a short hand  fir self.role = :member if self.role.nil?
  validates :name, length: {minimum: 1, maximum: 50}, presence: true

  # first validation runs if password_digest is nil, this makes sure that when we create a new user
  # it has a valid password
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  # this makes sure that when we are updating password, it is also 6 chars minimum
  # allow_blank skips the validation if no updated password is given.
  # this allows us to change other attributes on a user without being forced to set the password
  validates :password, length: { minimum: 6 }, allow_blank: true


  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  #Ruby's has_secure_password adds method to set and authenticate against a BCrypt password
  has_secure_password

  enum role: [:member, :admin, :moderator]

end
