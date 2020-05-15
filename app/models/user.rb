class User < ApplicationRecord
  has_many :missions
  has_many :categories, through: :missions
  has_many :messages
  has_many :messaged_missions, through: :messages, source: :mission

  # Include default devise modules. Others available are: 
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
