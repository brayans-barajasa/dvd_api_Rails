# app/models/category.rb
class Category < ApplicationRecord
  self.table_name = "category" # Tu tabla real

  has_many :film_categories, foreign_key: "category_id", class_name: "FilmCategory"
  has_many :films, through: :film_categories, class_name: "Film"
end
