# app/models/film_language.rb
class FilmLanguage < ApplicationRecord
  self.table_name = "language"   # <- esto apunta a la tabla existente
  has_many :films, foreign_key: :language_id
end
