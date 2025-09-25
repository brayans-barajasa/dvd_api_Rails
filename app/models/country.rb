class Country < ApplicationRecord
  self.table_name = "country"
  self.primary_key = "country_id"

  # Buscar país por fragmento de nombre
  scope :search_country, ->(query) { where("country ILIKE ?", "%#{query}%") }

  # Ordenar alfabéticamente
  scope :ordered, -> { order(country: :asc) }

  # Ejemplo: scope combinado con ciudades
  has_many :cities, class_name: "City", foreign_key: "country_id"
end
