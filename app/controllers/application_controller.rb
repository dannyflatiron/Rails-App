class ApplicationController < ActionController::Base
        before_action :configure_permitted_parameters, if: :devise_controller?
        protect_from_forgery with: :exception
        # before_action :authenticate_user!

        helper_method :morse_encode, :morse_encode_word


      MORSE_CODE = {
        "a" => ".-",
        "b" => "-...",
        "c" => "-.-.",
        "d" => "-..",
        "e" => ".",
        "f" => "..-.",
        "g" => "--.",
        "h" => "....",
        "i" => "..",
        "j" => ".---",
        "k" => "-.-",
        "l" => ".-..",
        "m" => "--",
        "n" => "-.",
        "o" => "---",
        "p" => ".--.",
        "q" => "--.-",
        "r" => ".-.",
        "s" => "...",
        "t" => "-",
        "u" => "..-",
        "v" => "...-",
        "w" => ".--",
        "x" => "-..-",
        "y" => "-.--",
        "z" => "--..",
        "0" => "-----",
        "1" => ".----",
        "2" => "..---",
        "3" => "...--",
        "4" => "....-",
        "5" => ".....",
        "6" => "-....",
        "7" => "--...",
        "8" => "---..",
        "9" => "----."
      }


    def morse_encode(str)
        str_downcase = str.downcase
        words = str_downcase.split(" ")
        encoded_words = words.map { |word| morse_encode_word(word) }
        encoded_words.join(" / ")
      end
      
      
    def morse_encode_word(word)
        letters = word.split("")
        codes = letters.map { |l| MORSE_CODE[l] }
        codes.join(" ")
    end

    def decodeMorse(string)
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
        
        

        
    protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    end


end
