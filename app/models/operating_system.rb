class OperatingSystem < ActiveRecord::Base
  has_many :items, :dependent=>:nullify
  has_many :softwares, :dependent=>:nullify
end
