class AboutsController < ApplicationController
  skip_before_action :ensure_current_user, only: :show
  def show
    render :show
  end
end