class Account < ApplicationRecord
  def check_mail
    begin
      settings = {address: self.address, port: self.port, user_name: self.email, password: self.password, enable_ssl: self.enable_ssl}
      Mail.defaults { retriever_method :imap, settings }
      # mails = Mail.find
      mails = Mail.find(:what => :first, :count => 100, :order => :asc)
      mails.each do |mail|
        if MailContent.find_by(message_id: mail.message_id).nil?
          mail_content = MailContent.new(message_id: mail.message_id, account_id: self.id)
          mail_content.to = mail.to.nil? ? nil : mail.to.join(",")
          mail_content.from = mail.from.nil? ? nil : mail.from.join(",")
          mail_content.cc = mail.cc.nil? ? nil : mail.cc.join(",")
          mail_content.subject = mail.subject
          mail_content.created_at = mail.date
          if mail.multipart?
            mail_content.is_multipart = true
            mail.parts.each do |p|
              if !p.content_type.index("text/plain").nil?
                mail_content.text_part = p.decoded
              elsif !p.content_type.index("text/html").nil?
                mail_content.html_part = p.decoded.gsub("\n","").gsub("\r","")
              end
            end
          else
            mail_content.text_part = mail.decoded
          end
          mail_content.save
        end
      end

    rescue => error
      self.error =  error.inspect.to_s
    end

    self.last_checked_at = Time.now
    self.save
  end
end

# File.read("a").split("\n").each do |line|
#   arr = line.split("|")
#   email = "#{arr[0]}@hotmail.com".downcase
#   password = arr[2]
#   if Account.find_by(email: email).nil?
#     Account.create(email: email, password: password)
#   end
# end
