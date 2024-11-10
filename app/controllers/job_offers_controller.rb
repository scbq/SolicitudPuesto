class JobOffersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_job_offer, only: [ :show, :edit, :update, :destroy ]

  def index
    @job_offers = JobOffer.all
  end

  def show
  end

  def new
    @job_offer = JobOffer.new
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    @job_offer.user = current_user

    if @job_offer.save
      redirect_to @job_offer, notice: "Publicación creada con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @job_offer.update(job_offer_params)
      redirect_to @job_offer, notice: "Publicación actualizada con éxito."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job_offer.destroy
    redirect_to job_offers_path, notice: "Publicación eliminada con éxito."
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user&.admin?
  end

  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
  end

  def job_offer_params
    params.require(:job_offer).permit(:title, :description)
  end
end
