# spec/integration/inventories_spec.rb
require "swagger_helper"

RSpec.describe "api/v1/inventories", type: :request do
  path "/api/v1/inventories" do
    get("list inventories") do
      tags "Inventories"
      produces "application/json"
      parameter name: :title, in: :query, type: :string, description: "Search by film title"
      parameter name: :page, in: :query, type: :integer, description: "Page number"
      parameter name: :per_page, in: :query, type: :integer, description: "Items per page"

      response(200, "successful") do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: { '$ref' => '#/components/schemas/Inventory' }
            },
            meta: { '$ref' => '#/components/schemas/PaginationMeta' }
          }

        # 🔹 Datos de prueba
        let!(:language) { Language.create!(name: "English") }
        let!(:category) { Category.create!(name: "Action") }
        let!(:film) do
          Film.create!(
            title: "Matrix",
            description: "Sci-Fi",
            language: language,
            rental_duration: 2,
            rental_rate: 4.99,
            replacement_cost: 19.99,
            rating: "G",
            fulltext: "matrix sci-fi"
          ).tap do |f|
            FilmCategory.create!(film: f, category: category)
          end
        end
        let!(:country) { Country.create!(country: "Colombia") }
        let!(:city) { City.create!(city: "Bogotá", country: country) }
        let!(:address) { Address.create!(district: "Centro", city: city) }
        let!(:store) { Store.create!(address: address) }
        let!(:inventory) { Inventory.create!(film: film, store: store) }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body["data"].first["film"]["title"]).to eq("Matrix")
          expect(body["data"].first["film"]["language"]["name"]).to eq("English")
          expect(body["data"].first["film"]["categories"].map { |c| c["name"] }).to include("Action")
        end
      end
    end
  end

  path "/api/v1/inventories/{id}" do
    get("show inventory") do
      tags "Inventories"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "Inventory ID"

      response(200, "successful") do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: { '$ref' => '#/components/schemas/Inventory' }
            },
            meta: { type: :object }
          }

        let!(:language) { Language.create!(name: "Spanish") }
        let!(:film) do
          Film.create!(
            title: "Amores Perros",
            description: "Drama",
            language: language,
            rental_duration: 2,
            rental_rate: 4.99,
            replacement_cost: 19.99,
            rating: "G",
            fulltext: "amores perros drama"
          )
        end
        let!(:country) { Country.create!(country: "México") }
        let!(:city) { City.create!(city: "CDMX", country: country) }
        let!(:address) { Address.create!(district: "Roma", city: city) }
        let!(:store) { Store.create!(address: address) }
        let!(:inventory) { Inventory.create!(film: film, store: store) }

        let(:id) { inventory.inventory_id }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body["data"].first["film"]["title"]).to eq("Amores Perros")
          expect(body["meta"]["count"]).to eq(1)
        end
      end

      response(404, "not found") do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
