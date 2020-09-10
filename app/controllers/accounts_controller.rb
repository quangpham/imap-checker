class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.order(id: :desc)
  end

  def show
    @mails = MailContent.where(account_id: @account.id).order(created_at: :desc)
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

  private
  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:address, :port, :email, :password, :enable_ssl)
  end

end
