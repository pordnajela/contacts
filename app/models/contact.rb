class Contact < ApplicationRecord

  belongs_to :contact_file, class_name: "ContactFile", foreign_key: "contact_file_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  scope :by_contact_file, ->(contact_file) { where(contact_file: contact_file) }
  scope :by_user, ->(user) { where(user: user) }
end
