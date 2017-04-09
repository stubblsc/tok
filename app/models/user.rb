class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_users, inverse_of: :user
  has_many :chatrooms, through: :chatroom_users, inverse_of: :users
  has_many :messages, inverse_of: :user
  has_one :rss_feed, inverse_of: :user
end
