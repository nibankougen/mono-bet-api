# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound do |exception|
    Rails.logger.error "Record not found: #{exception.message}"
    render json: { error: "not found" }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    Rails.logger.error "Invalid record: #{exception.message}"
    render json: { error: "parameter error" }, status: :bad_request
  end

  rescue_from ActiveModel::ValidationError do |exception|
    Rails.logger.error "Validation error: #{exception.message}"
    render json: { error: "parameter error" }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotUnique do |exception|
    Rails.logger.error "Record not unique: #{exception.message}"
    render json: { error: "parameter error" }, status: :bad_request
  end
end
