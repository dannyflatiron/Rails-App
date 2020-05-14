class Mission < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :messages
  has_many :user, through: :comments
end
