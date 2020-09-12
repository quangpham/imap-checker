class Account < ApplicationRecord
  before_save :validate_data_before_save
  after_create :check_mail

  def self.reassign_heroku_app_name
    accounts = Account.where(error: nil)
    heroku_app_names = HerokuApp.where(shared_ip: nil).order(:id).limit(accounts.count).pluck(:name)
    accounts.each_with_index {|acc,i| acc.update(heroku_app_name: heroku_app_names[i])}
  end

  def check_mail keys="UNSEEN"
    url = "http://#{self.heroku_app_name}.herokuapp.com/imap?email=#{self.email}&password=#{self.password}&address=#{self.imap_address}&keys=#{keys}"
    r = RestClient.get url
    res = JSON.parse(r.body).with_indifferent_access
    if res[:results]
      res[:results].each do |r|
        if MailContent.find_by(message_id: r[:message_id]).nil?
          MailContent.create(r.merge(account_id: self.id))
        end
      end
      self.update(last_checked_at: Time.now) if !res[:results].empty?
    end

    if res[:error]
      self.update(last_checked_at: Time.now, error: res[:error])
    end
  end

  def imap_address
    return "outlook.office365.com" if !self.email.index("@hotmail.").nil? || !self.email.index("@outlook.").nil?
    return "imap.gmx.com" if !self.email.index("@gmx.com").nil?
  end

  private

  def validate_data_before_save
    if self.heroku_app_name.nil?
      heroku_app_names = Account.where.not(heroku_app_name: nil).pluck(:heroku_app_name)
      if heroku_app = HerokuApp.where(shared_ip: nil).where.not(name: heroku_app_names).first
        self.heroku_app_name = heroku_app.name
      end
    end
  end
end
