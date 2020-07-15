module Images
  class UploaderService
    attr_reader :attachments_params, :errors

    def initialize(attachments_params:)
      @attachments_params = attachments_params
      @errors = []
    end

    def perform
      return @errors << 'No attachments given' if attachments_params.blank?

      @errors = attachments_params.each_with_object([]) do |attachment, errors|
        img = Image.new(attachment: attachment)
        next if img.save

        errors << [
          attachment.original_filename,
          img.errors.full_messages.join('. ')
        ].join(': ')

        errors
      end

      self
    end
  end
end
