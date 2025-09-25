# app/models/language.rb
class Language < ApplicationRecord
  self.table_name = "language"
  self.primary_key = "language_id"

  has_many :films

  # Scopes para búsqueda
  scope :by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }
  scope :ordered, -> { order(name: :asc) }

  def film_count
    films.count
  end
end
