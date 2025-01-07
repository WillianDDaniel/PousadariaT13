class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_inn_registration, if: :inn_owner_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :document, inn_attributes: [:name, :registration_number]])
  end

  def check_inn_registration
    return if request.controller_class.eql? InnDashboard::InnsController
    redirect_to edit_inn_dashboard_inns_path unless current_inn_owner.inn.valid?
  end

  def owner_active
    current_inn_owner if inn_owner_signed_in?
  end
end
