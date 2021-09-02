class QuestionController < ApplicationController
  def top
    @quests = Quest.all
  end
  def show
    @quest = Quest.find_by(id: params[:id])
  end
  def create
    @quest = Quest.new(title: params[:title], caption: params[:caption])
    @quest.save
    redirect_to("/question")
  end
  def newspot
  end
end
