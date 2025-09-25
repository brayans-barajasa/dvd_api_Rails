module Paginatable
  extend ActiveSupport::Concern
  include Pagy::Backend

  def paginate(collection)
    page  = (params[:page].presence  || 1).to_i
    limit = (params[:per_page].presence || Pagy::DEFAULT[:limit]).to_i
    pagy(collection, page: page, limit: limit)
  end

  def pagination_metadata(pagy_object)
    {
      current_page: pagy_object.page,
      per_page:     pagy_object.limit,
      total_pages:  pagy_object.pages,
      total_count:  pagy_object.count,
      next_page:    pagy_object.next,
      prev_page:    pagy_object.prev
    }
  end
end
