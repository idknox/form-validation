class TaskListsController < ApplicationController

  before_action :require_login

  def index
    @task_lists = get_task_list
    @user = User.find(session[:user_id])
  end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(
      :name => params[:task_list][:name],
      :user_id => session[:user_id]
    )
    if @task_list.save
      flash[:notice] = "Task List was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def update
    @task_list = TaskList.find(params[:id])
    @task_list.name = params[:task_list][:name]
    if @task_list.save
      flash[:notice] = "Your task list was successfully updated!"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @title = ""
    @task_list = TaskList.find(params[:id])
    @tasks = Task.where(
      :task_list_id => params[:id],
      :completed => false
    )
  end

  def destroy
    task_list = TaskList.find(params[:id])
    task_list.destroy
    flash[:notice] = "Task List deleted"
    redirect_to root_path
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to root_path
    end
  end

  def get_task_list
    User.find(session[:user_id]).task_lists.order(:name).to_a.map do |tl|
      {
        :task_list => tl,
        :tasks => tl.tasks_for_user(session[:user_id])
      }
    end
  end
end