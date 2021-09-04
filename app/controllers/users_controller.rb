class UsersController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user, {only: [:edit, :update, :logout]}
  #ログインしているユーザーがアクセスできない
  before_action :forbid_login_user, {only: [:index, :create, :login_form, :login]}
  #ログインしているユーザーと権限を持つユーザーが異なるときアクセスできない
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @user = User.new
    @loginuser = User.new
  end
  def userlist
    @users = User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def create
    @user = User.new(name: params[:name], email: params[:email], image_name: "default_user.png", password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/index")
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "変更を保存しました"
      redirect_to("/users/#{@user.id}/")
    else
      render("users/edit")
    end
  end
  def login_form
    @user = User.new
  end
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/question")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/question")
    end
  end
end
