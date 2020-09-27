class Speciality < ApplicationRecord
  belongs_to :doctor

  validates :name, presence: true
end
