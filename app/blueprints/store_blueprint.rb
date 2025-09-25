class StoreBlueprint < Blueprinter::Base
  identifier :store_id
  fields :last_update

  association :address, blueprint: AddressBlueprint
end
