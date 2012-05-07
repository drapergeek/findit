Feature: Manage Items
  As a user
  I want to be able to manage items
  So that I can control my inventory

  Scenario: A user viewing an empty items screen
    Given I am logged in
    And I do not have any items
    When I visit the items page
    Then I should see no items
    And I should see a new items link

  Scenario: A user views a page with items
    Given I am logged in
    And I have items in the database
    When I visit the items page
    Then I should see the items

 Scenario: A user can create an item
    Given I am logged in
    When I visit the items page
    And I click the new item link
    And I fill in the fields to create a new item
    When I create the item
    Then I should be on the page for the new item

 Scenario: A user can edit an item
    Given I am logged in
    And I have items in the database
    When I visit the items page
    And I click on an item
    And I click edit
    And I change the name
    And I update the item
    Then the name of the item should have changed

