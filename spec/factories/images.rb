FactoryBot.define do
  factory :image do
    attachment {
      tmp_file = Tempfile.new
      Rack::Test::UploadedFile.new(tmp_file, 'image/png')
      tmp_file.close
    }
  end
end
