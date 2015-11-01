class NotificationMailer < ApplicationMailer
    def send_alert(family, kid)
    @family = family
    @email = @family.email
    @kid = kid

    mail(to: @email, subject: 'ALERT! Child uses the screen for too long')
  end
end
