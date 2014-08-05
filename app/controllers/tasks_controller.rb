class TasksController < ApplicationController
  def new
    @task = Task.new
    @task_list = TaskList.find(params[:id])
  end

  def create
    puts "*" * 80
    puts params
    @task = Task.new(
      description: params[:task][:description],
      user_id: session[:user_id],
      task_list_id: params[:id]
    )
    @task.date = @task.create_date(params[:task])
    @task.save
    flash[:notice] = "Task was created successfully!"
    redirect_to root_path
  end
end
