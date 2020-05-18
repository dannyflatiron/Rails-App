class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  has_many :categories, through: :missions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :messaged_missions, through: :messages, source: :mission, dependent: :destroy

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


  def decodeMorse(string)
    binding.pry
    words = string.split("   ")
    result = words.map do |word|
      phrase = ""
      letters = word.split(" ")
      letters.each do |letter|
        case letter
        when ".-"
          phrase << "a"
        when "-..."
          phrase << "b"
        when "-.-."
          phrase << "c"
        when "-.."
          phrase << "d"
        when "."
          phrase << "e"
        when "..-."
          phrase << "f"
        when "--."
          phrase << "g"
        when "...."
          phrase << "h"
        when ".."
          phrase << "i"
        when ".---"
          phrase << "j"
        when "-.-"
          phrase << "k"
        when ".-.."
          phrase << "l"
        when "--"
          phrase << "m"
        when "-."
          phrase << "n"
        when "---"
          phrase << "o"
        when ".--."
          phrase << "p"
        when "--.-"
          phrase << "q"
        when ".-."
          phrase << "r"
        when "..."
          phrase << "s"
        when "-"
          phrase << "t"
        when "..-"
          phrase << "u" 
        when "...-"
          phrase << "v"
        when ".--"
          phrase << "w"
        when "-..-"
          phrase << "x"
        when "-.--"
          phrase << "y"
        when "--.."
          phrase << "z"  
        when "-----"
          phrase << "0"
        when ".----"
          phrase << "1"
        when "..---"
          phrase << "2"
        when "...--"
          phrase << "3"
        when "....-"
          phrase << "4"
        when "-----"
          phrase << "5"
        when "-...."
          phrase << "6"
        when "--..."
          phrase << "7"
        when "---.."
          phrase << "8" 
        when "----."
          phrase << "9"
        end
      end
      phrase
    end
    result.join(" ")
  end

end
