class CompletedTasksController < ApplicationController

  def create
    task = Task.find(params[:task][:id])
    task.completed = true
    task.save
    flash[:notice] = "Task Completed"
    redirect_to root_path
  end

  def index
    @title = " - Completed"
    @task_list = TaskList.find(params[:task_list_id])
    @tasks = Task.where(
      :task_list_id => params[:task_list_id],
      :completed =>  true
    )
  end
end
