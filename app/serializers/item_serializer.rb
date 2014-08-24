class ItemSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :make,
    :location_id,
    :short_location,
    :serial,
    :inventoried_at,
    :location_full_name,
    :user_name,
    :type_of_item,
    :ram,
    :hard_drive,
    :model_name,
    :purchased_at,
    :warranty_expires_at,
    :surplused_at,
    :operating_system_name,
    :processor

  def model_name
    object.model
  end
end
