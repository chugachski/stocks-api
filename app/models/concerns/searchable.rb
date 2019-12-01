module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def searching(params)
      Rails.logger.info "searching method params: #{params}"
      binding.pry

      if params.has_key? "filter"
        if params["filter"] = "all_companies_by_year"
          ids = Year.where(year: params[year]).map { |year| year.id }
          StatsProfile.by_ids(ids).by_annual_change(:desc)
        end
      else
        self.all
      end

      self.all
    end
  end
end


# filter=all_companies_by_year
# stat=annual_change
# stat=volatility
# stat=min
# stat=max
# stat=avg

# filter=all_years_by_company
# stat=annual_change
# stat=volatility
# stat=min
# stat=max
# stat=avg

# year_ids_2018 = Year.where(year: "2018").map { |year| year.id }
# @stats_profiles = StatsProfile.by_ids(year_ids_2018).by_annual_change(:desc)
# @year = "2018"
# render :annual_change
