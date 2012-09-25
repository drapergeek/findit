[![Build Status](https://secure.travis-ci.org/drapergeek/findit.png)](http://travis-ci.org/drapergeek/findit)
# Introduction
This is an inventory system that was originally designed for Virginia Tech Rec Sports.
It has been modified slightly to make it more generic and up to date.

# Development Setup
````
  bundle
  rake app:setup
  rake db:setup
  rake db:migrate
  rake db:test:prepare
````

# Testing Setup
````
  rake #This runs the full test suite minus the old Unit Tests
````

