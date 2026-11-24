class Employee < ApplicationRecord
    has_one_attached :profile_image
  validates :name, :email, :phone, :designation, presence: true
    validates :email, uniqueness:true
 def self.search(query)
    if query.present?
      where("name LIKE ?", "%#{sanitize_sql_like(query)}%")
    else
     puts ""
    end
  end
end
