# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  username         :string           not null
#  remaining_cheers :integer          not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
  validates :username, :remaining_cheers, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 , allow_nil: true }
  
  attr_reader :password
  # 
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  def self.find_by_credentials(username,pw)
    @user = User.find_by(username: username)
    @user && @user.is_password?(pw) ? @user : nil
  end
end
