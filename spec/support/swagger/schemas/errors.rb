module Swagger
  module Schemas
    ERROR_RESPONSE = {
      type: :object,
      properties: {
        error: { type: :string, example: "Not Found" },
        message: { type: :string, example: "Inventory not found" },
        status: { type: :integer, example: 404 }
      }
    }.freeze
  end
end
