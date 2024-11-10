class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      authenticated_root_path # Redirige al panel de control si es admin
    else
      job_offers_path # Redirige a la vista de trabajos si es un usuario común (employer)
    end
  end
end
