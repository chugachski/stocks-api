module Searchable
  extend ActiveSupport::Concern
  ALLOWED_STATS = [:min, :max, :avg, :ending, :volatility, :annual_change].freeze

  # instance methods
  included do
  end

  # class methods
  module ClassMethods
    def search(params)
      raise InvalidStatsParameter if params[:stat] && !ALLOWED_STATS.include?(params[:stat].to_sym)

      stats_profiles = StatsProfile.page(params[:page] || 1).per(params[:per_page] || 10)

      filters = params.slice(:year)
      if params.has_key?(:symbol)
        company = Company.find_by(symbol: params[:symbol].to_sym)
        raise NoCompanyExists if company.nil?
        filters[:company] = company[:id]
      end

      filters.each { |filter, value| stats_profiles = stats_profiles.send("by_#{filter}", value) }

      stats_profiles = stats_profiles.send("set_order", params[:stat] || :id, params[:order] || :asc)
      display_stat = params[:stat] || nil

      [stats_profiles, display_stat]
    end
  end
end
