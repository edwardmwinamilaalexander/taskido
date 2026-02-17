class TasksController < ApplicationController
  before_action :authenticate_user!          # Only logged-in users
  before_action :set_task, only: %i[show edit update destroy]


  def index
    @to_do = current_user.tasks.where(state: "to_do")
    @doing = current_user.tasks.where(state: "doing")
    @done = current_user.tasks.where(state: "done")
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  private

  def set_task
    # Ensure user can only access their own tasks
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :state)
  end
end
