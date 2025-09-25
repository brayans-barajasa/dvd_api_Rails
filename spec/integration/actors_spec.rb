require "swagger_helper"

RSpec.describe "api/v1/actors", type: :request do
  path "/api/v1/actors" do
    get("list actors") do
      tags "Actors"
      produces "application/json"
      parameter name: :search, in: :query, type: :string, description: "Search by first name or last name"
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
                  actor_id: { type: :integer },
                  first_name: { type: :string },
                  last_name: { type: :string },
                  full_name: { type: :string }
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

        let!(:actor1) { Actor.create!(first_name: "Tom", last_name: "Hanks") }
        let!(:actor2) { Actor.create!(first_name: "Morgan", last_name: "Freeman") }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"].size).to be >= 2
          expect(data["data"].map { |a| a["full_name"] }).to include("Tom Hanks", "Morgan Freeman")
        end
      end
    end
  end

  path "/api/v1/actors/{id}" do
    get("show actor") do
      tags "Actors"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "Actor ID"

      response(200, "successful") do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  actor_id: { type: :integer },
                  first_name: { type: :string },
                  last_name: { type: :string },
                  full_name: { type: :string }
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

        let!(:actor) { Actor.create!(first_name: "Robert", last_name: "De Niro") }
        let(:id) { actor.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"].first["full_name"]).to eq("Robert De Niro")
        end
      end

      response(404, "not found") do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
