class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Muestra todos los usuarios
  def index
    @users = User.all
  end

  # Muestra un usuario específico
  def show
  end

  # Formulario para crear un nuevo usuario
  def new
    @user = User.new
  end

  # Crea un nuevo usuario
  def create
    @user = User.new(user_params)
    generated_password = Devise.friendly_token.first(10)
    @user.password = generated_password
  
    if @user.save
      RegistrationMailer.with(user: @user, password: generated_password).user_created_email.deliver_now
      redirect_to admin_users_path, notice: "Usuario creado y notificado con éxito."
    else
      puts @user.errors.full_messages
      render :new, alert: "Hubo un problema al crear el usuario."
    end
  end
  

  # Formulario para editar un usuario específico
  def edit
  end

  # Actualiza un usuario específico
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "Usuario actualizado exitosamente."
    else
      render :edit, alert: "Hubo un problema al actualizar el usuario."
    end
  end

  # Elimina un usuario específico
  def destroy
    if @user.destroy
      puts "Usuario con ID #{@user.id} eliminado."
      redirect_to admin_users_path, notice: "Usuario eliminado exitosamente."
    else
      puts "Error al intentar eliminar el usuario con ID #{@user.id}:"
      puts @user.errors.full_messages
      redirect_to admin_users_path, alert: "Hubo un problema al eliminar el usuario."
    end
  end
  
  

  private


  def update_status
  @application = Application.find(params[:id])
  if @application.update(status: params[:status])
    redirect_to admin_application_path(@application), notice: "Estado actualizado correctamente."
  else
    redirect_to admin_application_path(@application), alert: "No se pudo actualizar el estado."
  end
end

  # Configura el usuario para acciones específicas
  def set_user
    @user = User.find(params[:id])
  end

  # Parámetros permitidos para un usuario
  def user_params
    params.require(:user).permit(:name, :email, :role)
  end

  # Asegura que solo los administradores tengan acceso a estas acciones
  def ensure_admin!
    if user_signed_in?
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user.admin?
    else
      redirect_to new_user_session_path, alert: "Debes iniciar sesión como administrador para acceder a esta página."
    end
  end
end
