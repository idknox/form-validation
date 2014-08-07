class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
    @users = get_names
  end

  def create
    @task = Task.new(
      description: params[:task][:description],
      user_id: session[:user_id],
      task_list_id: params[:task_list_id],
      user: params[:task][:user],
      complete: false
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
    redirect_to :back
  end

  def complete
    task = Task.find(params[:id])
    task.complete = true
    task.save
    flash[:notice] = "Task Completed"
    redirect_to root_path
  end

  private

  def get_names
    User.select(:name).to_a.map { |user| user.name }
  end
end