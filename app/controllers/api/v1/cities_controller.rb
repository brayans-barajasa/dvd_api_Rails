module Api
  module V1
    class CitiesController < ApplicationController
      before_action :set_country, only: [ :index ]

      def index
        cities = City.all
        cities = cities.by_country(@country.id) if @country.present?
        cities = search(cities, params[:search], [ :city ]) if params[:search].present?
        cities = cities.ordered

        paginated = paginate(cities)

        render_json(
          serialize_city(paginated),
          meta: pagination_metadata(paginated)
        )
      end

      def show
        city = City.find(params[:id])

        render_json(
          serialize_city([ city ]),
          meta: { count: 1 }
        )
      end

      private

      def set_country
        @country = Country.find(params[:country_id]) if params[:country_id].present?
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Country not found" }, status: :not_found
      end

      def serialize_city(collection)
        collection.as_json(
          only: [ :city_id, :city, :country_id ],
          include: {
            country: { only: [ :country_id, :country ] }
          }
        )
      end
    end
  end
end
