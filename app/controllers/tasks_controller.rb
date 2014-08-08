class TasksController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    if params[:date]
      @tasks = Task.get_filtered_tasks(params)
    else
      @tasks = Task.where(:user_id => session[:user_id])
    end
end
  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
    @users = User.get_names
  end

  def create
    @task = Task.new(
      :description => params[:task][:description],
      :user_id => session[:user_id],
      :task_list_id => params[:task_list_id],
      :assigned_to => params[:task][:assigned_to],
      :completed => false,
      :date => Date.parse(params[:task][:date])
    )

    if @task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      @users = User.get_names
      render :new
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to :back
  end
end