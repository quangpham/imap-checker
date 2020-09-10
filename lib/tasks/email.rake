namespace :email do

  task :check => :environment do
    5.times {
      if account = Account.where(last_checked_at: nil).first
        account.check_mail()
      elsif account = Account.order(:last_checked_at).first
        account.check_mail()
      end
    }
  end

end
