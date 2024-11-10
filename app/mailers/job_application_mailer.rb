# app/mailers/job_application_mailer.rb
class JobApplicationMailer < ApplicationMailer
  def new_application_notification(application)
    @application = application
    @admin_email = ENV["ADMIN_EMAIL"]

    mail(to: @admin_email, subject: "Nueva Postulación Recibida")
  end
end
