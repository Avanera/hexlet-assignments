class AddUserRefToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :user
  end
end
