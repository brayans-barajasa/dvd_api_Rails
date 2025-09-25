class CityBlueprint < Blueprinter::Base
  identifier :city_id
  fields :city, :last_update

  association :country, blueprint: CountryBlueprint
end
