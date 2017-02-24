class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable

  has_many :web_surveys
end
