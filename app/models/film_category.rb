# app/models/film_category.rb
class FilmCategory < ApplicationRecord
  self.table_name = "film_category"  # tabla intermedia

  belongs_to :film, foreign_key: "film_id", class_name: "Film"
  belongs_to :category, foreign_key: "category_id", class_name: "Category"
end
