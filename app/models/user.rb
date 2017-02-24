class User < ActiveRecord::Base
  has_many :web_surveys
end
