class PasswordMailer < ApplicationMailer
    def
        params[:users]

        mail to: params[:users].email
    end
end
