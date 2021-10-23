class PlayQuestController < ApplicationController
  def challenge
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
  def destroy
    @play = PlayQuest.find_by(user_id: @current_user)
    @play.destroy
    flash[:notice] = "クエストへの挑戦をキャンセルしました"
    redirect_to("/mypage")
  end
  def play
    if PlayQuest.find_by(user_id: @current_user)
      @play = PlayQuest.find_by(user_id: @current_user)
      @quest = Quest.find_by(id: @play.quest_id)
    else
      flash[:notice] = "クエストを受注してください"
      redirect_to("/mypage")
    end
  end
end