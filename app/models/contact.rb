class Contact < ApplicationRecord

  belongs_to :user, class_name: "User", foreign_key: "user_id"

  scope :by_user, ->(user) { where(user: user) }
end
