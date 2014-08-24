require "spec_helper"

feature "item types" do
  scenario "the user adds a new item_type" do
    log_in
    visit item_types_path
    fill_in "Name", with: "Smartboard"
    click_on "Create Item type"

    create_item do
      select "Smartboard", from: "Type of item"
    end

    expect(page).to have_item_type("Smartboard")
  end

  def create_item(name: "New Item Name")
    visit new_item_path
    fill_in "Name", with: name
    select "Desktop", from: "Type of item"

    if block_given?
      yield
    end

    click_on "Create Item"
  end

  def have_item_type(type)
    have_data_role("type", type)
  end
end
