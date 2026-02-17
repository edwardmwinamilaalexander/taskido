class TasksController < ApplicationController
  before_action :authenticate_user! # Only logged-in users
  before_action :set_task, only: %i[show edit update destroy change_state]

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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  def change_state
    new_state = params[:state]

    if %w[to_do doing done].include?(new_state)
      @task.update(state: new_state)
      redirect_to tasks_path, notice: "Task moved to #{new_state.tr('_', ' ')}."
    else
      redirect_to tasks_path, alert: "Invalid state."
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :state)
  end
end
