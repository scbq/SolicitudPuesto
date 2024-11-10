class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected

  # Redirige después de restablecer la contraseña
  def after_resetting_password_path_for(resource)
    super(resource)
  end

  # La ruta que se usa después de enviar las instrucciones de restablecimiento de contraseña
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end
end
