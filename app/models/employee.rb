class Employee < ApplicationRecord
  belongs_to :department

  has_one_attached :profile_image
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :designation, presence: true
  validates :department_id, presence: true
  def self.search(query)
    if query.present?
      where("name LIKE ?", "%#{sanitize_sql_like(query)}%")
    else
      puts ""
    end
  end
end
