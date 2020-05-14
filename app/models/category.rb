class Category < ApplicationRecord
    has_many :posts
    has_many :users, through: :missions
end
