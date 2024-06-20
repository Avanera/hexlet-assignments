class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
  end

  def destroy
    # @task = Task.find(params[:id])
    # if @task.destroy
    #   redirect_to root_path, confirm: 'Really?'
    # else
    #   redirect_to task_path(@task), flash[:failure], message: 'Could not delete'
    # end
  end

  private

  def task_params
    params.required(:task).permit(%i[name description status creator performer completed])
  end
end
