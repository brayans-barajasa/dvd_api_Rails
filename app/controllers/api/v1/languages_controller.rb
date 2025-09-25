# app/controllers/api/v1/languages_controller.rb
module Api
  module V1
    class LanguagesController < ApplicationController
      def index
        languages = Language.all
        languages = languages.by_name(params[:search]) if params[:search].present?
        languages = languages.ordered

        render json: languages.as_json(
          only: [ :language_id, :name ],
          methods: [ :film_count ]
        )
      end

      def show
        language = Language.includes(:films).find(params[:id])

        render json: {
          language: language.as_json(only: [ :language_id, :name ]),
          statistics: {
            total_films: language.films.count,
            average_rental_rate: language.films.average(:rental_rate).to_f.round(2),
            films_by_rating: language.films.group(:rating).count,
            films_by_year: language.films.group(:release_year).count
          },
          recent_films: language.films.order(release_year: :desc)
                                .limit(5)
                                .as_json(only: [ :film_id, :title, :release_year, :rating ])
        }
      end
    end
  end
end
