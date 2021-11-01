class PlayQuestController < ApplicationController
  def challenge
    if PlayQuest.find_by(user_id: @current_user, clear_flg: false, delete_flg: false)
      @play = PlayQuest.find_by(user_id: @current_user)
      @play.quest_id = params[:id].to_i
    else
      @play = PlayQuest.new(user_id: @current_user.id, quest_id: params[:id])
    end
    @play.save
    @play_spots = Spot.where(quest_id: @play.quest_id).order(created_at: :asc)
    @play_spots.each do |spot|
      @play_spot = PlaySpot.new(user_id: @current_user.id, spot_id: spot.id, play_quest_id: @play.id)
      @play_spot.save
    end
    flash[:notice] = "このクエストに挑戦します"
    redirect_to("/mypage")
  end
  def destroy
    @play = PlayQuest.find_by(user_id: @current_user, clear_flg: false, delete_flg: false)
    @play.delete_flg = true
    @play.save
    flash[:notice] = "クエストへの挑戦をキャンセルしました"
    redirect_to("/mypage")
  end
  def play
    if PlayQuest.find_by(user_id: @current_user, clear_flg: false, delete_flg: false)
      @play = PlayQuest.find_by(user_id: @current_user, clear_flg: false, delete_flg: false)
      @quest = Quest.find_by(id: @play.quest_id)
      @spots = PlaySpot.where(play_quest_id: @play.id, clear_flg: false, delete_flg: false).order(created_at: :asc)
      @spot = Spot.find_by(id: @spots.first.spot_id)
      if @spots.size <= 0
        redirect_to("/")
      end
    else
      flash[:error_message] = "挑戦するクエストを選択してください"
      redirect_to("/mypage")
    end
  end
  def answer_check
    @play = PlayQuest.find_by(user_id: @current_user, clear_flg: false, delete_flg: false)
    @spots = PlaySpot.where(play_quest_id: @play.id, clear_flg: false, delete_flg: false).order(created_at: :asc)
    @play_spot = PlaySpot.find_by(id: @spots.first.id, clear_flg: false, delete_flg: false)
    @spot = Spot.find_by(id: @play_spot.spot_id)
    if @spot.answer == params[:user_answer]
      @play_spot.clear_flg = true
      @play_spot.save
      @spots = PlaySpot.where(play_quest_id: @play.id, clear_flg: false, delete_flg: false).order(created_at: :asc)
      if @spots.size > 0
        redirect_to("/play/correct")
      else
        @play.clear_flg = true
        @play.save
        redirect_to("/play/correct")
      end
    else
      flash[:error_message] = "不正解..."
      redirect_to("/play")
    end
  end

  def correct_answer
    @play_quests = PlayQuest.where(user_id: @current_user, delete_flg: false).order(created_at: :desc)
    @play = @play_quests.first
    @quest = Quest.find_by(id: @play.quest_id)
    @cleared_spots = PlaySpot.where(play_quest_id: @play.id, clear_flg: true, delete_flg: false).order(created_at: :desc)
    @spot = Spot.find_by(id: @cleared_spots.first.spot_id)
    @quest_spots = Spot.where(quest_id: @quest.id)
  end

  def quest_clear
    @play_quests = PlayQuest.where(user_id: @current_user, delete_flg: false).order(created_at: :desc)
    @play = @play_quests.first
  end
end