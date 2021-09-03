class UsersController < ApplicationController
  def index
  end
  def userlist
    @users = User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end
end
