namespace :email do

  task :check => :environment do
     Account.where(last_checked_at: nil).order(:id).each {|a| a.check_mail}
    # 1.times {
    #   if account = Account.where(last_checked_at: nil, error: nil).first
    #     account.check_mail()
    #   elsif account = Account.where(error: nil).order(:last_checked_at).first
    #     account.check_mail()
    #   end
    # }
  end

end
