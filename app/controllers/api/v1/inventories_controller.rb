# app/controllers/api/v1/inventories_controller.rb
module Api
  module V1
    class InventoriesController < ApplicationController
      def index
        # 🔹 Query con includes (evita N+1) + Ransack
        inventories = Inventory.includes(
          film: [ :language, :categories, :actors ],
          store: { address: { city: :country } }
        ).ransack(params[:q]).result(distinct: true)

        if params[:all] == "true"
          render_json(
            InventoryBlueprint.render_as_hash(inventories.to_a)
          )
        else
          pagy_object, records = paginate(inventories)
          render_json(
            InventoryBlueprint.render_as_hash(records),
            meta: pagination_metadata(pagy_object)
          )
        end
      end

      def show
        inventory = Inventory.includes(
          film: [ :language, :categories, :actors ],
          store: { address: { city: :country } }
        ).find(params[:id])

        render_json(
          InventoryBlueprint.render_as_hash(inventory),
          meta: { count: 1 }
        )
      end
    end
  end
end
