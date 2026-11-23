class Employee < ApplicationRecord
    has_one_attached :profile_image
  validates :name, :email, uniquenss:true, :phone, :designation, presence: true

end
