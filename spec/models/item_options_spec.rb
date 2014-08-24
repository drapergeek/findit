require "spec_helper"

describe ItemOptions do
  describe "#item_types" do
    it "includes the default item_types" do
      default_item_types = ItemOptions::DEFAULT_ITEM_TYPES.sort
      expect(ItemOptions.new.item_types).to eq(default_item_types)
    end

    it "includes any custom item types" do
      item_type = create(:item_type)
      expect(ItemOptions.new.item_types).to include(item_type.name)
    end
  end
end
