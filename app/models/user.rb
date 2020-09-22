class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,  uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 5}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email_no_case = email.downcase.strip
    user = User.find_by_email(email_no_case)
    if user && user.authenticate(password)
        user
    end
  end
end
