class PlayQuestController < ApplicationController
  def challenge
    if PlayQuest.find_by(user_id: @current_user, clear: false)
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
    @play = PlayQuest.find_by(user_id: @current_user, clear: false)
    @play.clear = true
    @play.save
    flash[:notice] = "クエストへの挑戦をキャンセルしました"
    redirect_to("/mypage")
  end
  def play
    if PlayQuest.find_by(user_id: @current_user, clear: false)
      @play = PlayQuest.find_by(user_id: @current_user, clear: false)
      @quest = Quest.find_by(id: @play.quest_id)
      @spots = PlaySpot.where(play_quest_id: @play.id, clear: false).order(created_at: :asc)
      @spot = Spot.find_by(id: @spots.first.spot_id)
      if @spots.size <= 0
        redirect_to("/")
      end
    else
      flash[:notice] = "クエストを受注してください"
      redirect_to("/mypage")
    end
  end
  def answer_check
    @play = PlayQuest.find_by(user_id: @current_user, clear: false)
    @spots = PlaySpot.where(play_quest_id: @play.id, clear: false).order(created_at: :asc)
    @play_spot = PlaySpot.find_by(id: @spots.first.id)
    @spot = Spot.find_by(id: @play_spot.spot_id)
    if @spot.answer == params[:user_answer]
      @correct_spot = PlaySpot.find_by(id: @spots.first.id)
      @correct_spot.clear = true
      @correct_spot.save
      flash[:notice] = "正解！"
      @spots = PlaySpot.where(play_quest_id: @play.id, clear: false).order(created_at: :asc)
      if @spots.size > 0
        redirect_to("/play/correct")
      else
        @play.clear = true
        @play.save
        flash[:notice] = "全クリ"
        redirect_to("/mypage")
      end
    else
      flash[:notice] = "不正解..."
      redirect_to("/play")
    end
  end

  def correct_answer
    @spots = PlaySpot.all
    @play = PlayQuest.find_by(user_id: @current_user)
    @quest = Quest.find_by(id: @play.quest_id)
  end
end