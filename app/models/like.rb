class Like < ApplicationRecord
  belongs_to :post
  belongs_to :like_users, class_name: "User", foreign_key: "user_id"
end
