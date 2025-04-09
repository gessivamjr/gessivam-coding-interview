class UsersController < ApplicationController

  def index
    users = User.by_company(params[:company_id])

    render json: users
  end

  private

  def search_params
    params.permit(:username)
  end

end
