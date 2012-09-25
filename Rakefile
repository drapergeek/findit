require File.expand_path('../config/application', __FILE__)
require 'rake'

Findit::Application.load_tasks
task(:default).clear
task :default => ['db:migrate', 'db:test:prepare',:cucumber, :spec]
