class Software < ActiveRecord::Base
  has_many :installations, :dependent=>:destroy
  has_many :items, :through=>:installations
  belongs_to :operating_system

  delegate :name, :to => :operating_system, :prefix => true, :allow_nil => true

  def to_s
    name
  end
end
