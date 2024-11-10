class User < ApplicationRecord
  # Define los roles: solo Esteban debe tener el rol `admin`
  enum role: { admin: 0, employee: 1 }

  # Relaciones
  has_many :job_offers, dependent: :nullify # Solo el admin puede crear `job_offers`
  has_many :applications, dependent: :destroy # Las aplicaciones pertenecen a cada usuario

  # Configuración de Devise
  # Excluimos `registerable` para que los usuarios no puedan registrarse por sí mismos
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Validaciones adicionales si es necesario
  # validates :nombre, presence: true # ejemplo de campo adicional, si deseas agregar más datos personales relevantes
end
