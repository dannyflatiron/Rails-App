class Mission < ApplicationRecord
  belongs_to :user #gives the reader and writer method
  belongs_to :category
  has_many :messages
  has_many :users, through: :messages #gives only the writer method for the plural 
end
