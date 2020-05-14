class User < ApplicationRecord
  # Include default devise modules. Others available are: :recoverable, :rememerable,
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable,
         :validatable, :omniauthable, omniauth_providers: [:google]
end
