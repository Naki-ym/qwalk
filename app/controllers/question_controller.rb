class QuestionController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user, {only: [:create, :newspot, :edit, :update, :destroy, :publish, :unpublish]}
  #ログインしているユーザーと権限を持つユーザーが異なるときアクセスできない
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy, :publish, :unpublish]}

  def top
    @quest = Quest.new
    @quests = Quest.where(publish: true).where.not(user_id: @current_user.id).order(created_at: :desc)
  end

  def mypage
    # @quest = Quest.new
    @published_quests = Quest.where(user_id: @current_user.id, publish: true).order(created_at: :desc)
    @not_published_quests = Quest.where(user_id: @current_user.id, publish: false).order(created_at: :desc)
    @play = PlayQuest.find_by(user_id: @current_user.id, clear_flg: false, delete_flg: false)
    if @play
      @play_quest = Quest.find_by(id: @play.quest_id)
    end
  end

  def new
    @quest = Quest.new
  end

  def show
    @quest = Quest.find_by(id: params[:id])
    @spots = Spot.where(quest_id: @quest.id)
    @user = @quest.user
    @play_quest = PlayQuest.find_by(user_id: @current_user.id, clear_flg: false, delete_flg: false)
  end
  def create
    @quest = Quest.new(title: params[:title], caption: params[:caption], user_id: @current_user.id)
    if @quest.save
      flash[:notice] = "クエストを作成しました"
      redirect_to("/mypage")
    else
      @quests = Quest.all.order(created_at: :desc)
      render("question/new")
    end
  end
  def newspot
    @quest = Quest.find_by(id: params[:id])
  end
  def edit
    @quest = Quest.find_by(id: params[:id])
  end
  def update
    @quest = Quest.find_by(id: params[:id])
    @quest.title = params[:title]
    @quest.caption = params[:caption]
    if @quest.save
      flash[:notice] = "変更を保存しました"
      redirect_to("/question/#{@quest.id}/")
    else
      render("question/edit")
    end
  end
  def destroy
    @quest = Quest.find_by(id: params[:id])
    @spots = Spot.where(quest_id: @quest.id)
    @spots.destroy_all
    @quest.destroy
    flash[:notice] = "クエストを削除しました"
    redirect_to("/mypage")
  end
  def publish
    @quest = Quest.find_by(id: params[:id])
    @spots = Spot.find_by(quest_id: @quest.id)
    if @spots == nil
      @user = @quest.user
      @error_message = "地点を追加してください"
      render("question/show")
    else
      @quest.publish = true
      @quest.save
      flash[:notice] = "クエストを公開しました"
      redirect_to("/mypage")
    end
  end
  def unpublish
    @quest = Quest.find_by(id: params[:id])
    @quest.publish = false
    @quest.save
    flash[:notice] = "クエストを非公開にしました"
    redirect_to("/mypage")
  end

  def ensure_correct_user
    @quest = Quest.find_by(id: params[:id])
    if @quest.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/question")
    end
  end
end
