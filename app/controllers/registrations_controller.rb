class RegistrationsController < ApplicationController
  def new
    # Renderiza el formulario
  end

  def create
    # Recoge los datos del formulario
    name = params[:name]
    email = params[:email]
    message = params[:message]

    # Envía el correo a Esteban usando la dirección configurada en el archivo de entorno
    RegistrationMailer.with(name: name, email: email, message: message).registration_request_email.deliver_now

    # Redirige a la página de inicio de sesión tras enviar la solicitud
    redirect_to new_user_session_path, notice: "Tu solicitud ha sido enviada. Esteban revisará tus datos y se pondrá en contacto."
  end
end
