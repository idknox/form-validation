class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
    @users = User.get_names
  end

  def create
    @task = Task.new(
      description: params[:task][:description],
      user_id: session[:user_id],
      task_list_id: params[:task_list_id],
      user: params[:task][:user],
      assigned_user_id: User.find_by(:name => params[:task][:user]).id,
      complete: false
    )
    @task.date = @task.create_date(params[:task])

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

  def complete
    task = Task.find(params[:id])
    task.complete = true
    task.save
    flash[:notice] = "Task Completed"
    redirect_to root_path
  end

  def index
    @user = User.find(session[:user_id])
    @tasks = Task.where(:assigned_user_id => session[:user_id])
  end

  def search
    @tasks = Task.where("description LIKE '%#{params[:q]}%'")
    render :search
  end
end