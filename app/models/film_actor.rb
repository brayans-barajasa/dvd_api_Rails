class FilmActor < ApplicationRecord
  self.table_name = "film_actor"

  belongs_to :film, foreign_key: "film_id"
  belongs_to :actor, foreign_key: "actor_id"
end
