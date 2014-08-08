class TasksController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    @tasks = get_filtered_tasks(params)
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

  def complete
    task = Task.find(params[:id])
    task.completed = true
    task.save
    flash[:notice] = "Task Completed"
    redirect_to root_path
  end

  def search
    @tasks = Task.where("description LIKE '%#{params[:q]}%'")
    render :search
  end

  private

  def get_filtered_tasks(params)
    if params[:date]
      Task.filtered_tasks(params)
    else
      Task.where(:user_id => session[:user_id])
    end
  end
end