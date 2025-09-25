module Api
  module V1
    class FilmsController < ApplicationController
      include Pagy::Backend

      def index
        films = Film.includes(:language, :actors, :categories, :stores)
        films = films.search(search_params)
        films = films.ordered

        pagy_object, records = pagy(films, page: params[:page])

        render_json(
          records,
          film_json_options,
          meta: {
            filters: available_filters
          }.merge(pagination_metadata(pagy_object))
        )
      end

      def show
        film = Film.includes(:language, :actors, :categories, :stores, inventories: :rentals)
                   .find(params[:id])

        render_json(
          [ film ],
          film_detail_json_options,
          meta: { count: 1 }
        )
      end

      private

      def search_params
        params.permit(:title, :actor, :category, :year, :rating, :city, :language_id, :language)
      end

      def film_json_options
        {
          only: %i[film_id title description release_year rental_rate rating length],
          include: {
            language: { only: %i[language_id name] },
            actors: { only: %i[actor_id first_name last_name] },
            categories: { only: %i[category_id name] }
          }
        }
      end

      def film_detail_json_options
        {
          only: %i[film_id title description release_year rental_rate rating length rental_duration replacement_cost special_features],
          include: {
            language: { only: %i[language_id name] },
            actors: { only: %i[actor_id first_name last_name], methods: [ :full_name ] },
            categories: { only: %i[category_id name] },
            stores: {
              only: [ :store_id ],
              include: { address: { include: { city: { only: [ :city ] }, country: { only: [ :country ] } } } }
            }
          }
        }
      end

      def available_filters
        {
          languages: Language.all.map { |l| { id: l.language_id, name: l.name } },
          ratings: Film.distinct.pluck(:rating).compact,
          categories: Category.distinct.pluck(:name).sort
        }
      end

      def pagination_metadata(pagy)
        {
          current_page: pagy.page,
          total_pages: pagy.pages,
          total_count: pagy.count,
          per_page: pagy.vars[:items],
          next_page: pagy.next,
          prev_page: pagy.prev
        }
      end
    end
  end
end
