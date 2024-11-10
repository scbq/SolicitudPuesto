class Application < ApplicationRecord
  belongs_to :job_offer
  belongs_to :user

  validates :job_offer_id, presence: true
  validates :user_id, presence: true
    
  enum status: { pendiente: 'Pendiente', en_proceso: 'En Proceso', aceptada: 'Aceptada', rechazada: 'Rechazada' }
      
  # Define un estado predeterminado
    after_initialize :set_default_status, if: :new_record?
  
    
  def set_default_status
    self.status ||= 'Pendiente'
  end
  
end
