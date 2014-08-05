class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:id])
  end

  def create
    @task = Task.new(
      description: params[:task][:description],
      user_id: session[:user_id],
      task_list_id: params[:id]
    )
    @task.date = @task.create_date(params[:task])

    if @task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to root_path
  end

end