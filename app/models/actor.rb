class Actor < ApplicationRecord
  self.table_name = "actor"
  self.primary_key = "actor_id"

  has_many :film_actors, class_name: "FilmActor", foreign_key: "actor_id"
  has_many :films, through: :film_actors

  # Método para nombre completo
  def full_name
    "#{first_name} #{last_name}"
  end

  # 🔹 Campos permitidos en búsquedas
  def self.ransackable_attributes(auth_object = nil)
    %w[actor_id first_name last_name]
  end

  # 🔹 Asociaciones permitidas en búsquedas
  def self.ransackable_associations(auth_object = nil)
    %w[film_actors films]
  end

  # Scopes
  scope :ordered, -> { order(last_name: :asc, first_name: :asc) }
end
