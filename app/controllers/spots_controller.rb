class SpotsController < ApplicationController
  def new
    @spot = Spot.new
    @quest = Quest.find_by(id: params[:id])
    session[:current_quest] = @quest.id
  end
  def create
    @quest_id = session[:current_quest]
    @spot = Spot.new(quest_id: @quest_id, q_text: params[:q_text], answer: params[:answer], a_text: params[:a_text])
    if @spot.save
      flash[:notice] = "新しい地点を登録しました #{session[:current_quest]}"
      redirect_to("/question")
    else
      @quest = Quest.find_by(id: @quest_id)
      render("spots/new")
    end
  end
end
