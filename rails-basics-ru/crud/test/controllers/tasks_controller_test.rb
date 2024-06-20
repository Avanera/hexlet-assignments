require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get show' do
    get task_url(tasks(:one))
    assert_response :success
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
  end

  test 'should create a task' do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: 'John', creator: 'Doe' } }
    end
    assert_redirected_to(task_path(Task.last))
    assert_equal 'Task was successfully created.', flash[:notice]
  end

  test 'should get edit' do
    get edit_task_url(tasks(:one))
    assert_response :success
  end

  test 'should update the task' do
    task_to_update = tasks(:one)

    patch task_url(task_to_update), params: { task: { name: 'Updated' } }, xhr: true

    assert_equal(task_to_update.reload.name, 'Updated')
    assert_redirected_to(task_path(task_to_update))
    assert_equal 'Task was successfully updated.', flash[:notice]
  end

  test 'should delete the task' do
    task_to_delete = tasks(:one)

    assert_difference('Task.count', -1) do
      delete task_url(task_to_delete)
    end

    assert_redirected_to(tasks_path)
    assert_equal 'Task was successfully deleted.', flash[:notice]
  end
end
