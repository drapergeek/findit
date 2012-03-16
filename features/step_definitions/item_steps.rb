Given /I am logged in/ do
  #this right now doesn't matter b/c all users are logged in
end

Given /I do not have any items/ do
  Item.destroy_all
end

When /I visit the items page/ do
  visit(items_path)
end

Then /I should see no items/ do
  page.should_not have_css("tr.odd")
end

Then /I should see a new items link/ do
  page.should have_link("New",:href=>new_item_path)
end

Given /I have items in the database/ do
  @item_names = ["item1", "item2", "item3", "item4"]
  @item_names.each do |name|
    Factory.create(:item, :name=>name)
  end
end

Then /I should see the items/ do
  save_and_open_page
  @item_names.each do |name|
    page.should have_content(name)
  end

end
