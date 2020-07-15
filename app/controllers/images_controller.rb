class ImagesController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :handle_missing_param

  def new
    @title = 'Home page'
    @images = Image.all
  end

  def create
    result = ::Images::UploaderService.new(attachments_params: upload_params[:attachments]).perform

    if result.errors.blank?
      redirect_to root_path, notice: 'Images have been successfully uploaded.'
    else
      redirect_to root_path, alert: "Could not process images: #{result.errors.join("<br />")}"
    end
  end

  private

  def upload_params
    params.require(:uploads).permit(attachments: [])
  end

  def handle_missing_param
    redirect_to root_path, alert: $!.message
  end
end
