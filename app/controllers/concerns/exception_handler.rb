module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message, code: e.code }, status: :unprocessable_entity
    end

    rescue_from InvalidStatsParameter do |e|
      render json: { message: e.message, code: e.code, acceptable_stats: e.stats }, status: e.http_status
    end

    rescue_from NoCompanyExists do |e|
      render json: { message: e.message, code: e.code,}, status: e.http_status
    end
  end
end
