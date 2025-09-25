require "swagger_helper"

RSpec.describe "api/v1/cities", type: :request do
  path "/api/v1/cities" do
    get("list cities") do
      tags "Cities"
      produces "application/json"
      parameter name: :search, in: :query, type: :string, description: "Search by city name"
      parameter name: :country_id, in: :query, type: :integer, description: "Filter by country id"
      parameter name: :page, in: :query, type: :integer, description: "Page number for pagination"
      parameter name: :per_page, in: :query, type: :integer, description: "Items per page"

      response(200, "successful") do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  city_id: { type: :integer },
                  city: { type: :string },
                  country_id: { type: :integer },
                  country: {
                    type: :object,
                    properties: {
                      country_id: { type: :integer },
                      country: { type: :string }
                    }
                  }
                }
              }
            },
            meta: {
              type: :object,
              properties: {
                current_page: { type: :integer },
                total_pages: { type: :integer },
                total_count: { type: :integer }
              }
            }
          }

        let!(:country) { Country.create!(country: "Colombia") }
        let!(:city) { City.create!(city: "Bogotá", country: country) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"].first["city"]).to eq("Bogotá")
          expect(data["data"].first["country"]["country"]).to eq("Colombia")
        end
      end
    end
  end

  path "/api/v1/cities/{id}" do
    get("show city") do
      tags "Cities"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "City ID"

      response(200, "successful") do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  city_id: { type: :integer },
                  city: { type: :string },
                  country_id: { type: :integer },
                  country: {
                    type: :object,
                    properties: {
                      country_id: { type: :integer },
                      country: { type: :string }
                    }
                  }
                }
              }
            },
            meta: {
              type: :object,
              properties: {
                count: { type: :integer }
              }
            }
          }

        let!(:country) { Country.create!(country: "Argentina") }
        let!(:city) { City.create!(city: "Buenos Aires", country: country) }
        let(:id) { city.city_id } # 👈 importante: usar city_id, no city.id

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"].first["city"]).to eq("Buenos Aires")
          expect(data["data"].first["country"]["country"]).to eq("Argentina")
        end
      end

      response(404, "not found") do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
