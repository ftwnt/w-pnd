class PlaysController < ApplicationController
  TAKEN_IMAGES_COUNT = 10.freeze

  before_action :prepare_data, only: :index
  before_action :init_play, only: :create

  def index; end

  def create
    respond_to do |format|
      format.js do
        @play.save
        assign_plays_collection
        render layout: false
      end
    end
  end

  private

  def assign_plays_collection
    @plays = Play.includes(:image)
  end

  def prepare_data
    @title = 'Game page'
    assign_plays_collection
    @game_collection = ::Plays::RetrievalService.new.perform

    gon.push(
      {
        gameCollection: @game_collection
      }
    )
  end

  def play_strong_params
    params.require(:play).permit(:timer_value, :image_id)
  end

  def init_play
    @play= Play.new(play_strong_params)
  end
end
