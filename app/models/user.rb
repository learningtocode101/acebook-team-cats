class User < ApplicationRecord
  has_many :posts
  has_many :comments, dependent: :destroy
  has_secure_password

  validates_presence_of :first_name, :message => "Meow, what is your a first name?"
  validates_presence_of :last_name, :message => "Meow, what is your last name?"
  validates_presence_of :birthday, :message => "Meow, when is your birthday?"
  validates_presence_of :password
  validates :password, length: { in: 6..10 }
  validates_presence_of :password, :message => "Meow, what is your password?"
  validates_presence_of :gender, :message => "Meow, what is your gender?"
  validates_presence_of :email, :message => "Meow, what is your email?"
  validates_format_of :email, :with => /.*@.*/, :message => "Meow, email must include @."
  validates_uniqueness_of :email, :message => "Meow, email must be unique."

end
