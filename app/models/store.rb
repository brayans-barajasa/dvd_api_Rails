# app/models/store.rb
class Store < ApplicationRecord
  self.table_name = "store"

  belongs_to :manager, foreign_key: "manager_staff_id", class_name: "Staff"
  belongs_to :address, foreign_key: "address_id", class_name: "Address"

  has_many :inventories, foreign_key: "store_id", class_name: "Inventory"
  has_many :films, through: :inventories, class_name: "Film"
end
