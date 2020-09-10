class MailContentsController < ApplicationController

  def show
    @mail = MailContent.find(params[:id])
  end

end
