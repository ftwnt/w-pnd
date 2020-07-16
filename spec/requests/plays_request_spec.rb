require 'rails_helper'

RSpec.describe "Plays", type: :request do
  describe 'GET /index' do
    subject { get '/plays' }

    it 'returns http success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'assigns the data' do
      subject

      expect(assigns(:title)).to eq 'Game page'
      expect(assigns(:plays)).to eq Play.all
    end

    it 'calls service to retrieve game data' do
      expect(::Plays::RetrievalService).to receive_message_chain(:new, :perform)

      subject
    end
  end
end
