class Address < ApplicationRecord
  self.table_name = "address"
  self.primary_key = "address_id"

  belongs_to :city
  has_many :customers
  has_many :staff_members, class_name: "Staff", foreign_key: "address_id"
  has_many :stores
end
