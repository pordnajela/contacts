class ContactFile < ApplicationRecord

  has_many :contacts, class_name: "Contact", foreign_key: "contact_file_id", dependent: :destroy
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  scope :by_user, ->(user) { where(user: user) }
end
