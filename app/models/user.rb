class User < ActiveRecord::Base

  has_secure_password

  def authenticate_with_credentials(email, password)
    clean_email = email.strip.downcase

    @user = User.find_by_email(clean_email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
end
