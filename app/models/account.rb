class Account < ApplicationRecord

  def self.reassign_heroku_app_name
    accounts = Account.where(error: nil)
    heroku_app_names = HerokuApp.where(shared_ip: nil).order(:id).limit(accounts.count).pluck(:name)
    accounts.each_with_index {|acc,i| acc.update(heroku_app_name: heroku_app_names[i])}
  end

  def check_mail
    url = "http://#{self.heroku_app_name}.herokuapp.com/imap?email=#{self.email}&password=#{self.password}"
    r = RestClient.get url
    res = JSON.parse(r.body).with_indifferent_access
    if res[:results]
      res[:results].each do |r|
        if MailContent.find_by(message_id: r[:message_id]).nil?
          MailContent.create(r)
        end
      end
      self.update(last_checked_at: Time.now) if !res[:results].empty?
    end

    if res[:error]
      self.update(last_checked_at: Time.now, error: res[:error])
    end
  end

end
