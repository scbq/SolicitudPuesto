class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[show edit update destroy]

  def index
    @applications = current_user.applications
  end

  def show
  end

  def new
    @job_offer = JobOffer.find(params[:job_offer_id])
    @application = Application.new(job_offer_id: params[:job_offer_id])
  end
  

  def update
    if @application.update(application_params)
      redirect_to @application, notice: "Aplicación actualizada exitosamente."
    else
      render :edit, alert: "Hubo un problema al actualizar la aplicación."
    end
  end  

  def create
    @application = current_user.applications.build(application_params)

    if @application.save
      JobApplicationMailer.new_application_notification(@application).deliver_now
      redirect_to applications_path, notice: "Tu postulación ha sido enviada exitosamente."
    else
      render :new
    end
  end

  def destroy
    @application.destroy
    redirect_to applications_path, notice: "La aplicación fue eliminada con éxito."
  end
  

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:job_offer_id, :description)
  end

  def update_status
    @application = Application.find(params[:id])
    if @application.update(status: params[:status])
      redirect_to admin_application_path(@application), notice: "Estado actualizado correctamente."
    else
      redirect_to admin_application_path(@application), alert: "No se pudo actualizar el estado."
    end
  end
  
end
