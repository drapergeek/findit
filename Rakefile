require File.expand_path('../config/application', __FILE__)
require 'rake'

Findit::Application.load_tasks
task(:default).clear
task :default => [:spec, :cucumber, 'app:dev:prime']
