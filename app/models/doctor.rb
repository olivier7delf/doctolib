class Doctor < ApplicationRecord
  # We can add email for keep it for later. -> email user != email pro
  belongs_to :user
  has_many :specialities
  has_many :schedules

  validates :phone, presence: true, length: { minimum: 10, maximum: 10 }
  validates :city, presence: true, length: { minimum: 2, maximum: 50 }
  validates :address, presence: true, length: { minimum: 2, maximum: 120 }
  validates :user, uniqueness: true
end
