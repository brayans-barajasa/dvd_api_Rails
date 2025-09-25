module Searchable
  extend ActiveSupport::Concern

  # 🔹 Aplica búsqueda sobre cualquier colección y columnas
  # collection -> ActiveRecord::Relation
  # query -> valor a buscar
  # columns -> columnas sobre las cuales buscar
  def search(collection, query, columns)
    conditions = columns.map { |col| "#{col} ILIKE :q" }.join(" OR ")
    collection.where(conditions, q: "%#{query}%")
  end
end
