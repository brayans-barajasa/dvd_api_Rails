module Api
  module V1
    class ActorsController < ApplicationController
      def index
        actors  = Actor.ransack(params[:q])
        actors = actors.result(distinct: true).ordered

        pagy_object, records = paginate(actors)

        render_json(
          serialize_actor(records),
          meta: pagination_metadata(pagy_object)
        )
      end

      def show
        actor = Actor.find(params[:id])

        render_json(
          serialize_actor([ actor ]),
          meta: { count: 1 }
        )
      end

      private

      def serialize_actor(collection)
        collection.as_json(
          only: %i[actor_id first_name last_name],
          methods: [ :full_name ]
        )
      end
    end
  end
end
