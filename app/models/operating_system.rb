class OperatingSystem < ActiveRecord::Base
  attr_accessible :name, :info
  has_many :items, :dependent=>:nullify
  has_many :softwares, :dependent=>:nullify
  default_scope :order=>['name']
end
