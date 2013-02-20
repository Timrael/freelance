class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, :foreign_key => "author_id"

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
