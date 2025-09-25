class InventoryBlueprint < Blueprinter::Base
  identifier :inventory_id
  fields :last_update

  association :film, blueprint: FilmBlueprint
  association :store, blueprint: StoreBlueprint
end
