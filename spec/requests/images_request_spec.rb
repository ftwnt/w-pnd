require 'rails_helper'

RSpec.describe 'Images', type: :request do
  describe 'GET /new' do
    let(:expected_title) { 'Home page' }

    subject { get '/images/new' }

    it 'returns http success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'assigns correct title' do
      subject
      expect(assigns(:title)).to eq expected_title
    end

    context 'when images present' do
      let!(:image) { create(:image) }

      it 'returns images' do
        subject
        expect(assigns(:images)).to eq [image]
      end
    end

    context 'when no images present' do
      it 'returns images' do
        subject
        expect(assigns(:images)).to eq []
      end
    end
  end

  describe 'POST /create' do
    subject { post '/images', params: params }

    context 'when no params passed' do
      let(:params) { nil }

      it 'redirects to root page with alert' do
        subject

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('param is missing or the value is empty: uploads')
      end

      it 'does not execute service to upload files' do
        expect(::Images::UploaderService).to_not receive(:new)

        subject
      end
    end

    context 'when params passed' do
      let(:params) { { uploads: { attachments: [] } } }
      let(:service_stub) do
        instance_double('::Images::UploaderService', errors: errors)
      end
      before do
        allow(::Images::UploaderService)
          .to receive_message_chain(:new, :perform)
          .and_return(service_stub)
      end

      context 'and service succeeds' do
        let(:errors) { [] }

        it 'redirects to root page with success notice' do
          subject

          expect(response).to redirect_to(root_path)
          expect(flash[:notice]).to eq('Images have been successfully uploaded.')
        end
      end

      context 'and service returns errors' do
        let(:errors) { ['few', 'errors'] }
        let(:rendered_errors) { errors.join("<br />") }

        it 'redirects to root page with alert' do
          subject

          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq "Could not process images: #{rendered_errors}"
        end
      end
    end
  end
end
