class FilmBlueprint < Blueprinter::Base
  identifier :film_id

  fields :title, :description, :release_year, :rental_duration,
         :rental_rate, :length, :replacement_cost, :rating,
         :special_features

  association :language, blueprint: LanguageBlueprint
  association :actors, blueprint: ActorBlueprint
  association :categories, blueprint: CategoryBlueprint
end
