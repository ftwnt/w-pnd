class PlaysController < ApplicationController
  TAKEN_IMAGES_COUNT = 10.freeze

  before_action :prepare_data, only: :index

  def index; end

  def create
  end

  private

  def prepare_data
    @title = 'Game page'
    @plays = Play.all
    @game_collection = ::Plays::RetrievalService.new.perform

    gon.push(
      {
        gameCollection: @game_collection
      }
    )
  end
end
