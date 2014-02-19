class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :make, :model, :short_type, :location_id, :short_location, :serial
end
