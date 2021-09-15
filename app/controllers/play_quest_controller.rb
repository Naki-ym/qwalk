class PlayQuestController < ApplicationController
  def play
    if PlayQuest.find_by(user_id: @current_user)
      @play = PlayQuest.find_by(user_id: @current_user)
      @play.quest_id = params[:id].to_i
    else
      @play = PlayQuest.new(user_id: @current_user.id, quest_id: params[:id])
    end
    @play.save
    flash[:notice] = "このクエストに挑戦します"
    redirect_to("/mypage")
  end
end