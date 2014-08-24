class ItemOptions
  def item_types
    [Item::ITEM_TYPES + custom_item_types].flatten.sort
  end

  def buildings
    Building.all.order(:name)
  end

  private

  def custom_item_types
    ItemType.all.map(&:name)
  end
end
