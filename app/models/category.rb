class Category < ApplicationRecord
    has_many :missions
    has_many :users, through: :missions
end
