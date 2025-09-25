# app/models/film.rb
class Film < ApplicationRecord
  self.table_name = "film"
  self.primary_key = "film_id"

  has_many :film_actors, foreign_key: "film_id", class_name: "FilmActor"
  has_many :actors, through: :film_actors

  has_many :film_categories, foreign_key: "film_id", class_name: "FilmCategory"
  has_many :categories, through: :film_categories

  has_many :inventories
  has_many :stores, through: :inventories

  belongs_to :language, foreign_key: :language_id

  scope :ordered, -> { order(title: :asc) }

  # 🔹 Solo dejamos lo necesario para que Ransack funcione
  def self.ransackable_attributes(auth_object = nil)
    %w[film_id title description release_year rating language_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[language categories actors inventories stores]
  end
end
