Given /I am logged in/ do
  @user = create(:user)
  visit sign_in_path
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password
  click_button 'Sign in'
end

Given /I do not have any items/ do
  Item.destroy_all
end

When /I visit the items page/ do
  visit(items_path)
end

Then /I should see no items/ do
  within "table#items" do
    page.should_not have_css("tr.item_row")
  end
end

Then /I should see a new items link/ do
  page.should have_link("New",:href=>new_item_path)
end

Given /I have items in the database/ do
  @item_names = ["item1", "item2", "item3", "item4"]
  @item_names.each do |name|
    create(:item, :name=>name)
  end
end

Then /I should see the items/ do
  @item_names.each do |name|
    page.should have_content(name)
  end
end

When "I click the new item link" do
  click_link("New")
end

When "I fill in the fields to create a new item" do
  fill_in "item_name", :with=>"My New Item"
  check "item_in_use"
  select "Desktop", :from => "Type of item"
end

When "I create the item" do
  click_button "Create Item"
end

When "I update the item" do
  click_button "Update Item"
end


Then "I should be on the page for the new item" do
  page.should have_css("h1", text: 'My New Item')
end

When "I click on an item" do
  click_link "item1"
end

When "I click edit" do
  click_link "Edit"
end

When /^I change the name to "([^"]*)"$/ do |name|
  fill_in "item_name", with: name
end

Then /^the name of the item should be "([^"]*)"$/ do |name|
  page.should have_css("h1", text: name)
end
