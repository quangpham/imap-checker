class EtsyUploaderRecord < ActiveRecord::Base
  self.abstract_class = true

  establish_connection({
    "adapter"=> "postgresql",
    "encoding"=> "unicode",
    "gssencmode" => "disable",
    "url" => ENV["NINEID_DATABASE_URL"] || "postgres://postgres:Trangbeo1@masscrawler-db.quangpham.com:5432/etsy-uploader"
  })

end
