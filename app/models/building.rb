class Building < ActiveRecord::Base
  has_many :ips, :dependent => :nullify
  has_many :locations, :dependent => :nullify

  def to_s
    name
  end
end
