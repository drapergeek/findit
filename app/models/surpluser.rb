class Surpluser
  def initialize(item)
    @item = item
  end

  def surplus
    set_non_nil_info
    set_surplus_time
    remove_software
    remove_user
    remove_locations
    remove_ips
    remove_os
    set_not_in_use

    item
  end

  private
  attr_reader :item

  def set_surplus_time
    item.surplused_at = Time.now
  end

  def remove_user
    if item.user
      item.info += "\n The user was #{item.user.full_info} when surplused."
      item.user = nil
    end
  end

  def remove_software
    item.softwares.each do |s|
      item.info += "\n Software #{s.name} was installed when surplused."
    end

    item.installations.delete_all
  end

  def remove_locations
    if item.location
      item.info += "\n The item was located at #{item.location.full_name} when surplused"
      item.location = nil
    end
  end

  def set_non_nil_info
    if item.info.nil?
      item.info = ""
    end
  end

  def remove_ips
    item.ips.each do |ip|
      item.info +=  "\n The IP #{ip.number} was assigned when surplused."
      ip.item_id = nil
    end
  end

  def remove_os
    if item.operating_system
      item.info += "\n The OS #{item.operating_system.name} was installed when surplused."
      item.operating_system = nil
    end
  end

  def set_not_in_use
    item.in_use = false
  end
end
