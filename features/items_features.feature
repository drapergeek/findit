Feature: Manage Items
  As a user
  I want to be able to manage items
  So that I can control my inventory

  Scenario: A user viewing all items
    Given I am logged in
    And I do not have any items
    When I visit the items page
    Then I should see no items
    And I should see a new items link
