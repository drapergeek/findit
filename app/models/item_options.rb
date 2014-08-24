class ItemOptions
  DEFAULT_ITEM_TYPES = [
    "Desktop",
    "Mobile",
    "Laptop",
    "Printer",
    "Virtual Machine",
    "Other",
    "Server"
  ]

  def item_types
    [DEFAULT_ITEM_TYPES + custom_item_types].flatten.sort
  end

  def buildings
    Building.all.order(:name)
  end

  private

  def custom_item_types
    ItemType.all.map(&:name)
  end
end
