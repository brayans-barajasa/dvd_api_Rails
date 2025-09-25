class City < ApplicationRecord
  self.table_name = "city"
  self.primary_key = "city_id"

  belongs_to :country
  has_many :addresses
  has_many :customers, through: :addresses

  # Scopes realmente útiles
  scope :by_country, ->(country_id) { where(country_id: country_id) }
  scope :ordered, -> { order(city: :asc) }
end
