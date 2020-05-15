class Message < ApplicationRecord
    belongs_to :user
    belongs_to :mission

    validates :content, presence: true
    
end
