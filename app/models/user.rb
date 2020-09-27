class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :schedules

  validates :firstname, presence: true, length: { minimum: 2, maximum: 60 }
  validates :lastname, presence: true, length: { minimum: 2, maximum: 60 }
  validates :phone, presence: true, length: { minimum: 10, maximum: 10 }, uniqueness: true

  validates :firstname, uniqueness: { scope: :lastname }

  attribute :is_doctor, :boolean, default: false
end
