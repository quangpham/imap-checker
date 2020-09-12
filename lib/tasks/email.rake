namespace :email do

  task :check => :environment do
     Account.where("last_checked_at is not null and heroku_app_name is not null").order(:last_checked_at).each {|a| a.check_mail}
  end

end
