module Admin
  class ApplicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!
    before_action :set_application, only: [:show, :update_status, :destroy]

    def index
      @applications = Application.all
    end

    def show
    end

    def update_status
      if @application.update(status: params[:status])
        redirect_to admin_application_path(@application), notice: "Estado actualizado correctamente."
      else
        redirect_to admin_application_path(@application), alert: "No se pudo actualizar el estado."
      end
    end

    def destroy
      if @application.destroy
        redirect_to admin_applications_path, notice: "Postulación eliminada correctamente."
      else
        redirect_to admin_applications_path, alert: "No se pudo eliminar la postulación."
      end
    end

    private

    def set_application
      @application = Application.find(params[:id])
    end

    def ensure_admin!
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user.admin?
    end
  end
end
