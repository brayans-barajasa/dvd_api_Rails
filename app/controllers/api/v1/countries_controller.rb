module Api
  module V1
    class CountriesController < ApplicationController
      def index
        countries = Country.all
        countries = countries.search_country(params[:country]) if params[:country].present?
        countries = countries.ordered
        render_json(countries)
      end

      def show
        country = Country.find(params[:id])
        render_json(country)
      end

      private

      def render_json(resource)
        render json: resource.as_json(only: [ :country_id, :country ], include: { cities: { only: [ :city_id, :city ] } })
      end
    end
  end
end
