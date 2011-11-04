require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Factory.build(:project).valid?
  end
  
  test "Test to make sure an project has a name" do
    project = Factory.build(:project, :name => '')
    assert !project.valid?, 'The project should be valid because it doesnt  have a name'
    project.name = 'Demo'
    assert project.valid?, 'the projet should be valid now that it has a name'
  end
end
