class User < ApplicationRecord
  has_one :wallet ,dependent: :destroy
  has_many :loan,dependent: :destroy
  validates :upi ,presence:true,:format => {:with => /\A(^[\w.-]+@[\w.-]+$)\Z/, message: "Enter proper upi id" }
  after_create do |user|
    user.create_wallet(balance: 0)
  end
  enum :role, {user: 0,admin: 1}, prefix: true, scopes: false

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
