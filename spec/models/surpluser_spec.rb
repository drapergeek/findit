require 'spec_helper'

describe Surpluser do
  it 'removes all software from an item' do
    item = item_stub
    Installation.create!(item_id: item.id, software_id: create(:software).id)
    expect(item.softwares.count).to eq(1)

    item = Surpluser.new(item).surplus
    expect(item.softwares.count).to eq(0)
  end

  it 'writes the software installed to the info' do
    item = item_stub
    software = create(:software)
    software2 = create(:software)
    Installation.create!(item_id: item.id, software_id: software.id)
    Installation.create!(item_id: item.id, software_id: software2.id)

    item = Surpluser.new(item).surplus

    expect(item.info).to include("Software #{software.name} was installed when surplused.")
    expect(item.info).to include("Software #{software2.name} was installed when surplused.")
  end

  it 'removes the user and adds the line to the info about the user' do
    user = build_stubbed(:user)
    item = item_stub(user: user)

    item = Surpluser.new(item).surplus

    expect(item.user).to be_nil
    expect(item.info).to include("The user was #{user.full_info} when surplused.")
  end


  it 'removes the location and the building and adds it to the info' do
    location = build_stubbed(:location)
    item = item_stub(location: location)
    item = Surpluser.new(item).surplus
    expect(item.info).to include("The item was located at #{location.full_name} when surplused")
  end

  it 'removes the ips and puts them in the info' do
    ip1 = build_stubbed(:ip)
    ip2 = build_stubbed(:ip)
    item = item_stub(ips: [ip1, ip2])

    item = Surpluser.new(item).surplus

    expect(item.info).to include("The IP #{ip1.number} was assigned when surplused.")
    expect(item.info).to include("The IP #{ip2.number} was assigned when surplused.")
  end

  it 'removes the operating system and puts it in the info' do
    os = build_stubbed(:operating_system)
    item = item_stub(operating_system: os)

    item = Surpluser.new(item).surplus
    expect(item.info).to  include("The OS #{os.name} was installed when surplused.")
  end

  def item_stub(options = {})
    build_stubbed(:item, options)
  end
end
