module Swagger
  module Responses
    PAGINATION = {
      current_page: { type: :integer },
      total_pages: { type: :integer },
      total_count: { type: :integer }
    }.freeze
  end
end
