class OmniauthController < ApplicationController

    def passthru
        @user = User.create_from_provider_data(request.env['omni.auth'])
            if @user.persisted?
                sign_in_and_redirect @user
            else
                flash[:error] = 'There was a problem signing you in through Google. Please register or try again later.'
                redirect_to new_user_registration_url
            end
    end
end
