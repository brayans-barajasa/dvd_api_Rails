# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :record_conflict
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from StandardError, with: :internal_server_error if Rails.env.production?
  end

  private

  # 404
  def record_not_found(exception)
    render json: { error: "#{exception.model} no encontrado" }, status: :not_found
  end

  # 422
  def record_invalid(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  # 409
  def record_conflict(exception)
    render json: { error: "Conflicto de datos: #{exception.message}" }, status: :conflict
  end

  # 400
  def bad_request(exception)
    render json: { error: "Parámetro faltante: #{exception.param}" }, status: :bad_request
  end

  # 500
  def internal_server_error(_exception)
    render json: { error: "Error interno del servidor" }, status: :internal_server_error
  end
end
