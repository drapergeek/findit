require 'spec_helper'

describe Item do

  describe 'serial' do
    it' will upcase on input' do
      item = build(:item, serial: 'abc123')
      expect(item.serial).to eq('ABC123')
    end
  end

  describe '#not_inventoried_recently' do 
    it 'includes items where the inventoried_at is over a year ago' do
      not_inventoried_recently = create(:item, inventoried_at: 2.years.ago)
      inventoried_recently = create(:item, inventoried_at: 2.days.ago)

      expect(Item.not_inventoried_recently).to eq([not_inventoried_recently])
    end

    it 'includes any item that has never been inventoried' do
      never_inventoried = create(:item, inventoried_at: nil)
      inventoried = create(:item, inventoried_at: 1.week.ago)

      expect(Item.not_inventoried_recently).to eq([never_inventoried])
    end
  end

  describe '#in_use' do
    it 'includes items where in_use is true' do
      in_use = create(:item, in_use: true)
      not_in_use = create(:item, in_use: 'false')

      expect(Item.in_use).to eq([in_use])
    end
  end

  describe '#by_type' do
    it 'only returns items with that type' do
      correct_type = create(:item, type_of_item: 'Desktop')
      create(:item, type_of_item: 'Laptop')

      expect(Item.by_type('Desktop')).to eq([correct_type])
    end
  end
end
