require 'rails_helper'

describe Images::UploaderService do
  describe '#perform' do
    let(:service) { described_class.new(attachments_params: params) }
    subject { service.perform }

    context 'when no attachments passed' do
      let(:params) { [] }

      it { is_expected.to eq ['No attachments given'] }
    end

    context 'when attachments passed' do
      let(:file) { Rack::Test::UploadedFile.new(Tempfile.open.path, 'image/png')}
      let(:params) { [file] }

      context 'and images could be created' do
        it 'creates images' do
          expect { subject }.to change(Image, :count).by(params.count)
        end

        it 'has no resulting errors' do
          subject

          expect(service.errors).to eq []
        end
      end

      context 'and images could not be created' do
        let(:errors) { ['few', 'errors'] }
        let(:expected_errors) do
          params.map { "#{file.original_filename}: #{errors.join('. ')}" }
        end

        before do
          allow_any_instance_of(Image).to receive(:save) { false }
          allow_any_instance_of(Image)
            .to receive_message_chain(:errors, :full_messages)
            .and_return(errors)
        end

        it 'does not create images' do
          expect { subject }.to_not change(Image, :count)
        end

        it 'returns corresponding errors' do
          subject

          expect(service.errors).to eq expected_errors
        end
      end
    end
  end
end
