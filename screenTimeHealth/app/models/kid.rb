class Kid < ActiveRecord::Base
  belongs_to :family
  has_many :session
  has_secure_token :unique_token
end
