class EncodedMessageMailer < ApplicationMailer

    def send_coded_message(receiver, sender, message)
        @receiver = receiver
        @sender = sender
        @message = message

        mail(to: "takeheeddesigns@gmail.com" ,
        subject: "Hey #{@receiver.name} try to break my code!",
        reply_to: @sender.email
        )
    end


        

end
