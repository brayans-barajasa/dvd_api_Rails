# app/models/inventory.rb
class Inventory < ApplicationRecord
  self.table_name  = "inventory"
  self.primary_key = "inventory_id"

  belongs_to :film,  foreign_key: "film_id",  class_name: "Film"
  belongs_to :store, foreign_key: "store_id", class_name: "Store"

  # # 🔹 Scope de ordenamiento por título de la película
  # # app/models/inventory.rb
  # scope :ordered, -> {
  #   left_joins(:film)
  #     .select("inventory.*, film.title AS film_title")
  #     .order("film.title ASC")
  # }

  # 🔹 Campos permitidos en búsquedas con Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[inventory_id film_id store_id last_update]
  end

  # 🔹 Asociaciones permitidas en búsquedas con Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[film store]
  end
end
