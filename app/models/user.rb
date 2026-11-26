class User < ApplicationRecord
  belongs_to :employee, optional: true
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin employee] }
end
