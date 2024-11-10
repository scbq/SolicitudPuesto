# spec/models/application_spec.rb
require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:user) { User.create(name: "Felipe Aguilera", email: "felipe@example.com", password: "password") }
  let(:job_offer) { JobOffer.create(title: "Ingeniero Informático", description: "Descripción de prueba") }

  it "crea una postulación con usuario y oferta de trabajo válidos" do
    application = Application.new(user: user, job_offer: job_offer, description: "Postulación de prueba")

    expect(application).to be_valid
    expect(application.save).to be_truthy
    expect(application.user).to eq(user)
    expect(application.job_offer).to eq(job_offer)
  end

  it "envía una notificación de postulación al administrador tras crear una postulación" do
    ActionMailer::Base.deliveries.clear

    expect {
      Application.create!(user: user, job_offer: job_offer, description: "Postulación de prueba")
    }.to change { ActionMailer::Base.deliveries.count }.by(1)

    email = ActionMailer::Base.deliveries.last
    expect(email.to).to include(ENV['ADMIN_EMAIL'])
    expect(email.subject).to eq("Nueva Postulación Recibida")
  end
end
