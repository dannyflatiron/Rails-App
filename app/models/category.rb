class Category < ApplicationRecord
    has_many :missions
    validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "Only letters allowed" }
    
end
