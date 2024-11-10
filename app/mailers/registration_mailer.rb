class RegistrationMailer < ApplicationMailer
  def registration_request_email
    @name = params[:name]
    @message = params[:message]
    @user_email = params[:email]

    mail(to: ENV["ADMIN_EMAIL"], subject: "Nueva Solicitud de Registro de #{@name}")
  end

  def user_created_email
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Bienvenido a la Plataforma")
  end

  def new_application_notification(application)
    @application = application
    @admin_email = "faaf6@hotmail.com"
    mail(to: @admin_email, subject: "Nueva Postulación Recibida")
  end
end
