class TasksController < ApplicationController
  def index   # list all tasks
    @tasks = Task.all
  end

  def show    # show one task
    @task = Task.find(params[:id])
  end

  def new     # display form for new task
    @task = Task.new
  end

  def create  # handle submission of new task
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "Task was created successfully!"
    else
      render :new
    end
  end

  def edit    # display form to edit existing task
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully!"
  end

  private

  def task_params
    params.require(:task).permit(:content)
  end
end