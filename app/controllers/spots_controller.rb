class SpotsController < ApplicationController
  def new
    @spot = Spot.new
    @quest = Quest.find_by(id: params[:id])
    @quest_id = @quest.id
    session[:current_quest] = @quest.id
  end
  def create
    @quest_id = session[:current_quest]
    @spot = Spot.new(quest_id: @quest_id, q_text: params[:q_text], answer: params[:answer], a_text: params[:a_text], lat: params[:lat], lng: params[:lng])
    if @spot.save
      flash[:notice] = "新しい地点を登録しました #{@spot.lat}"
      redirect_to("/question/#{@quest_id}")
    else
      @quest = Quest.find_by(id: @quest_id)
      render("spots/new")
    end
  end
end
