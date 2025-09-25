Dir[Rails.root.join("spec/support/swagger/**/*.rb")].each { |f| require f }

config.swagger_docs = {
  "v1/swagger.json" => {
    openapi: "3.0.1",
    info: { title: "DVD API", version: "v1" },
    servers: [
      { url: "http://localhost:3000", description: "Servidor local" }
    ],
    components: {
      schemas: {
        Inventory: Swagger::Schemas::INVENTORY,
        Film: Swagger::Schemas::FILM,
        Store: Swagger::Schemas::STORE,
        Language: Swagger::Schemas::LANGUAGE,
        Category: Swagger::Schemas::CATEGORY,
        Actor: Swagger::Schemas::ACTOR,
        Address: Swagger::Schemas::ADDRESS,
        City: Swagger::Schemas::CITY,
        Country: Swagger::Schemas::COUNTRY,
        PaginationMeta: Swagger::Schemas::PAGINATION_META,
        ErrorResponse: Swagger::Schemas::ERROR_RESPONSE
      }
    }
  }
}
