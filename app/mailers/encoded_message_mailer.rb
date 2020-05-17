class EncodedMessageMailer < ApplicationMailer

    def send_coded_message(receiver, sender, message)
        @receiver = receiver
        @sender = sender
        @message = message
    end

end
