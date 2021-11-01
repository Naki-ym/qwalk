class SpotsController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user
  #ログインしているユーザーと権限を持つユーザーが異なるときアクセスできない
  before_action :ensure_correct_user, {only: [:show, :edit, :update, :destroy]}

  def new
    @spot = Spot.new
    @spot.lat = 35.6810208016824
    @spot.lng = 139.7674398589082
    @quest = Quest.find_by(id: params[:id])
    # @quest_id = @quest.id
    session[:current_quest] = @quest.id
  end
  def create
    @quest_id = session[:current_quest]
    @spot = Spot.new(quest_id: @quest_id, q_text: params[:q_text], answer: params[:answer], a_text: params[:a_text], lat: params[:lat], lng: params[:lng])
    if @spot.save
      flash[:notice] = "新しい地点を登録しました"
      redirect_to("/question/#{@quest_id}")
    else
      @quest = Quest.find_by(id: @quest_id)
      render("spots/new")
    end
  end
  def show
    @spot = Spot.find_by(id: params[:id])
    @quest = Quest.find_by(id: @spot.quest_id)
    @user = User.find_by(id: @quest.user_id)
  end
  def edit
    @spot = Spot.find_by(id: params[:id])
    @quest = Quest.find_by(id: @spot.quest_id)
  end
  def update
    @spot = Spot.find_by(id: params[:id])
    @spot.q_text = params[:q_text]
    @spot.answer = params[:answer]
    @spot.a_text = params[:a_text]
    @spot.lat = params[:lat]
    @spot.lng = params[:lng]
    if @spot.save
      flash[:notice] = "地点の変更を保存しました"
      redirect_to("/spots/#{@spot.id}")
    else
      @quest = Quest.find_by(id: @spot.quest_id)
      render("spots/edit")
    end
  end
  def destroy
    @spot = Spot.find_by(id: params[:id])
    @quest = Quest.find_by(id: @spot.quest_id)
    @spot.destroy
    @spots = Spot.where(quest_id: @quest.id)
    if @spots.size == 0
      @quest.publish = false
      @quest.save
    end
    flash[:notice] = "地点を削除しました"
    redirect_to("/question/#{@quest.id}")
  end
  def ensure_correct_user
    spot = Spot.find_by(id: params[:id])
    quest = Quest.find_by(id: spot.quest_id)
    user = User.find_by(id: quest.user_id)
    if @current_user.id != user.id
      flash[:error_message] = "権限がありません"
      redirect_to("/question")
    end
  end
end
