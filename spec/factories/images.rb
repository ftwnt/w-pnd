FactoryBot.define do
  factory :image do
    attachment { Rack::Test::UploadedFile.new(Tempfile.open.path, 'image/png') }
  end
end
