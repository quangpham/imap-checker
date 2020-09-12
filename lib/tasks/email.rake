namespace :email do

  task :check => :environment do
     Account.where(last_checked_at: nil).order(:last_checked_at).each {|a| a.check_mail}
  end

end
