class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy, :check_mail]

  def index
    @accounts = Account.where(error: nil).where.not(last_checked_at: nil).order(:error).order(:id)
  end

  def show
    @mails = MailContent.where(account_id: @account.id).order(created_at: :desc).limit(100)
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.save
    redirect_to @account, notice: 'Account was successfully created.'
  end

  def update
    @account.update(account_params)
    redirect_to @account, notice: 'Account was successfully updated.'
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  def check_mail

  end

  private
  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:email, :password)
  end

end
