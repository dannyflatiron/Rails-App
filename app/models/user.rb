class User < ApplicationRecord
  # Include default devise modules. Others available are: :recoverable, :rememerable,
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: [:google_oauth2]


  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.provider = provider_data.provider
      # binding.pry
      user.name = provider_data.info.name
      user.uid = provider_data.uid
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
