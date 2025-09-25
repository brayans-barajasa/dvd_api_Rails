module Api
  module V1
    class ClientsController < ApplicationController
      def index
        clients = Client.all
        render_json(clients)
      end

      def show
        client = Client.find(params[:id])   # ❌ si no existe → record_not_found (404)
        render_json(client)
      end

      def create
        client = Client.create!(client_params)   # ❌ si falla validación → unprocessable_entity (422)
        render_json(client, status: :created)
      end

      def update
        client = Client.find(params[:id])        # ❌ si no existe → record_not_found (404)
        client.update!(client_params)            # ❌ si falla validación → unprocessable_entity (422)
        render_json(client)
      end

      def destroy
        client = Client.find(params[:id])        # ❌ si no existe → record_not_found (404)
        client.destroy
        render json: {
          message: "Cliente eliminado",
          id: client.id,
          full_name: client.full_name
        }, status: :ok
      end

      private

      def client_params
        # ❌ si falta client → bad_request (400)
        params.require(:client).permit(:first_name, :last_name, :email)
      end

      def render_json(resource, status: :ok)
        render json: resource.as_json(
          only: [ :id, :first_name, :last_name, :email ],
          methods: [ :full_name ]
        ), status: status
      end
    end
  end
end
