class WordsBulkUploadsController < ApplicationController
  def new
  end

  def create
    if params[:file].present?
      BulkUploadWordsService.call(params[:file])
      flash[:notice] = "File uploaded successfully! Processing will continue in the background."
      redirect_to words_path
    else
      flash[:alert] = "Please select a file to upload."
      render :new
    end
  end
end
