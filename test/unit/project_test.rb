require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert build(:project).valid?
  end

  test "Test to make sure an project has a name" do
    project = build(:project, :name => '')
    assert !project.valid?, 'The project should be valid because it doesnt  have a name'
    project.name = 'Demo'
    assert project.valid?, 'the projet should be valid now that it has a name'
  end

  test "Test to make sure keywords are not required" do
    project = build(:project)
    assert project.valid?, 'should be true because it is the default project and keywords is not required'
    project.keywords = 'hello world, o no, hey'
    assert project.valid?, 'should be true even after keywords are valid'
  end

  test "Make sure the keywords are stored properly" do
    keywords = 'hello world, list2, number 3'
    project = build(:project, :keywords => keywords)
    assert project.valid?, 'This should be true as it is a standard project'
    assert_equal project.keywords, keywords, 'This should be equal or the keywords are not stored properly'
  end
end
