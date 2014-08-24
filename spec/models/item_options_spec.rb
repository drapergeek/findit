require 'spec_helper'

describe ItemOptions do
  describe '#item_types' do
    it 'includes the default item_types' do
      expect(ItemOptions.new.item_types).to eq(Item::ITEM_TYPES.sort)
    end

    it 'includes any custom item types' do
      item_type = create(:item_type)
      expect(ItemOptions.new.item_types).to include(item_type.name)
    end
  end
end

