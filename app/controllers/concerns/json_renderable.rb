module JsonRenderable
  extend ActiveSupport::Concern

  # 🔹 Renderiza cualquier colección o recurso en JSON
  # options -> para as_json (only, include)
  # meta -> metadatos opcionales (paginación, etc.)
  def render_json(resource, options = {}, meta: {})
    render json: {
      meta: meta,
      data: resource.as_json(options)
    }
  end
end
