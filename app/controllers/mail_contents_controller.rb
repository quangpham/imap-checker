class MailContentsController < ApplicationController

  def index
    @mails = MailContent.order(created_at: :desc).page params[:page]
  end
  def show
    @mail = MailContent.find(params[:id])
  end

end
