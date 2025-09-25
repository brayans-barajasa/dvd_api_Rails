class Customer < ApplicationRecord
  self.table_name = "customer"
  self.primary_key = "customer_id"

  # Relaciones según el esquema
  belongs_to :store
  belongs_to :address
  has_one :city, through: :address
  has_one :country, through: :city

  # Scopes de búsqueda
  scope :search, ->(query) {
    where("first_name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query", query: "%#{query}%")
  }

  # Ordenar alfabéticamente por apellido y nombre
  scope :ordered, -> { order(last_name: :asc, first_name: :asc) }

  # Método para nombre completo
  def full_name
    "#{first_name} #{last_name}"
  end
end
