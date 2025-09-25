module Api
  module V1
    class CustomersController < ApplicationController
      def index
        customers = Customer.all
        customers = customers.search(params[:search]) if params[:search].present?
        customers = customers.ordered
        render_json(customers)
      end

      def show
        customer = Customer.find(params[:id])
        render_json(customer)
      end

      private

      def render_json(resource)
        render json: resource.as_json(
          only: [ :customer_id, :email ],
          methods: [ :full_name ],
          include: {
            address: {
              only: [ :address, :address2, :district, :postal_code, :phone ],
              include: {
                city: {
                  only: [ :city_id, :city ],
                  include: {
                    country: {
                      only: [ :country_id, :country ]
                    }
                  }
                }
              }
            },
            store: {
              only: [ :store_id ]
            }
          }
        )
      end
    end
  end
end
