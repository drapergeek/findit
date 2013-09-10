class InventoryItemOnPage < PageObject

  def with_basic_information
    self.name = 'My Computer'
    self.type = 'Desktop'
    self
  end

  def name=(name)
    fill_in 'Name', with: name
  end

  def type=(type)
    select type, from: 'Type of item'
  end

  def make=(make)
    fill_in 'Make', with: make
  end

  def model=(model)
    fill_in 'Model', with: model
  end

  def processor=(processor)
    fill_in 'Processor', with: processor
  end

  def ram=(ram)
    fill_in 'Ram', with: ram
  end

  def hard_drive=(hard_drive)
    fill_in 'Hard drive', with: hard_drive
  end

  def serial=(serial)
    fill_in 'Serial', with: serial
  end

  def unique_id=(unique_id)
    fill_in 'Unique ID', with: unique_id
  end

  def create!
    click_on 'Create Item'
  end

  def has_name?(name)
    page.has_css?("[data-role=name]", name)
  end

  def of_type?(type)
    page.has_css?("[data-role=type]", type)
  end

  def has_make?(make)
    page.has_css?("[data-role=make]", make)
  end

  def has_model?(model)
    page.has_css?("[data-role=model]", model)
  end

  def has_processor?(processor)
    page.has_css?("[data-role=processor]", processor)
  end

  def has_ram?(ram)
    page.has_css?("[data-role=ram]", text: ram)
  end

  def has_hard_drive?(hard_drive)
    page.has_css?("[data-role=hard-drive]", text: hard_drive)
  end

  def has_serial?(serial)
    page.has_css?("[data-role=serial]", text: serial)
  end

  def has_unique_id?(unique_id)
    page.has_css?("[data-role=unique-id]", text: unique_id)
  end
end
