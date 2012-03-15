Given /I am logged in/ do

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
