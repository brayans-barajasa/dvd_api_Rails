module Swagger
  module Schemas
    INVENTORY = {
      type: :object,
      properties: {
        inventory_id: { type: :integer },
        last_update: { type: :string, format: :date_time },
        film: { '$ref' => '#/components/schemas/Film' },
        store: { '$ref' => '#/components/schemas/Store' }
      }
    }.freeze
  end
end
