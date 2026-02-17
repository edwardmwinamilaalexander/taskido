class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  def index   # list all tasks
    @tasks = Task.all
  end

  def show    # show one task
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "Task was created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update  # handle submission of edits
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: "Task was updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # delete a task
    @task.destroy
    redirect_to tasks_path, notice: "Task was deleted successfully!"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content)
  end
end
