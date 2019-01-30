[![Build Status](https://secure.travis-ci.org/drapergeek/findit.png)](http://travis-ci.org/drapergeek/findit) [![Code Climate](https://codeclimate.com/github/drapergeek/findit.png)](https://codeclimate.com/github/drapergeek/findit)
# Introduction
This is an inventory system that was originally designed for Virginia Tech Rec Sports.
It has been modified slightly to make it more generic and up to date.

# Development Setup
````
  bin/setup
````

# Testing Setup
````
  rake #This runs the full test suite minus the old Unit Tests
````

# Deploying a new instance

* heroku create
* git push -u heroku master
* heroku run rake db:setup
* heroku run console - update the first user with actual information
* set all the ENV variables from the .env file
afaf
