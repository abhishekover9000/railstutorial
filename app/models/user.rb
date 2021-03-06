class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	attr_accessor :remember_token
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, 
							format: {with: VALID_EMAIL_REGEX},
							uniqueness: {case_sensitive: false}
	has_secure_password

	validates :password, length: {minimum: 6}, presence: true

	  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #Random token

  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  def remember # to remember a user for persistent sessions
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
  	update_attribute(:remember_digest, nil)
  end
end
