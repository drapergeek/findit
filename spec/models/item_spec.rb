require 'spec_helper'

describe Item do
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


  describe '#surplus' do
    it 'marks the time of the surplus' do
      item = create(:item)
      expect(item.surplused_at).to be_nil
      item.mark_as_surplused
      expect(item.surplused_at).not_to be_nil
    end

    it "surplus removes all software from an item" do
      item = create(:item)
      Installation.create!(item_id: item.id, software_id: create(:software).id)
      expect(item.softwares.count).to eq(1)

      item.mark_as_surplused
      expect(item.softwares.count).to eq(0)
    end

    it "surplus writes the software installed to the info" do
      item = create(:item)
      software = create(:software)
      software2 = create(:software)
      Installation.create!(item_id: item.id, software_id: software.id)
      Installation.create!(item_id: item.id, software_id: software2.id)

      item.mark_as_surplused

      expect(item.info).to include("Software #{software.name} was installed when surplused.")
      expect(item.info).to include("Software #{software2.name} was installed when surplused.")
    end

    it "surplus removes the user and adds the line to the info about the user" do
      user = create(:user)
      item = create(:item, user: user)
      item.mark_as_surplused
      expect(item.user).to be_nil
      expect(item.info).to include("The user was #{user.full_info} when surplused.")
    end


    it "surplus removes the location and the building and adds it to the info" do
      location = create(:location)
      item = create(:item, location: location)
      item.mark_as_surplused
      expect(item.info).to include("The item was located at #{location.full_name} when surplused")
    end

    it "surplus removes the ips and puts them in the info" do
      item = create(:item)
      ip1 = create(:ip)
      ip2 = create(:ip)
      item.ips << ip1
      item.ips << ip2
      item.mark_as_surplused
      expect(item.info).to include("The IP #{ip1.number} was assigned when surplused.")
      expect(item.info).to include("The IP #{ip2.number} was assigned when surplused.")
    end

    it "surplus removes the operating system and puts it in the info" do
      os = create(:operating_system)
      item = create(:item, operating_system: os)
      item.mark_as_surplused
      expect(item.info).to  include("The OS #{os.name} was installed when surplused.")
    end
  end
end
