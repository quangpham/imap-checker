class PubidRecord < ActiveRecord::Base
  self.abstract_class = true

  establish_connection({
    "adapter"=> "postgresql",
    "encoding"=> "unicode",
    "url" => ENV["NINEID_DATABASE_URL"] || "postgres://fqtrkvegusnpxs:f53c986150f90ae28ec3400379e5ebfcc646f392eb14ed2cae0fd2c1c5fd8eed@ec2-54-75-235-28.eu-west-1.compute.amazonaws.com:5432/debi3b41f3otv1"
  })

end
