class UsersController < ApplicationController
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
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], image_name: "default_user.png")
    if @user.save
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
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/question")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
