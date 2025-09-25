class AddressBlueprint < Blueprinter::Base
  identifier :address_id

  fields :address, :address2, :district, :postal_code, :phone, :last_update

  association :city, blueprint: CityBlueprint
end
