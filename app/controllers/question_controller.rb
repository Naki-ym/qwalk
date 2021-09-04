class QuestionController < ApplicationController
  #ログインしていないユーザーがアクセスできない
  before_action :authenticate_user, {only: [:create, :newspot, :edit, :update, :destroy]}

  def top
    @quest = Quest.new
    @quests = Quest.all.order(created_at: :desc)
  end
  def show
    @quest = Quest.find_by(id: params[:id])
  end
  def create
    @quest = Quest.new(title: params[:title], caption: params[:caption])
    if @quest.save
      flash[:notice] = "クエストを作成しました"
      redirect_to("/question")
    else
      @quests = Quest.all.order(created_at: :desc)
      render("question/top")
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
    @quest.destroy
    flash[:notice] = "クエストを削除しました"
    redirect_to("/question")
  end
end
