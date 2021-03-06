class User < ActiveRecord::Base
 
  attr_accessor :password, :password_confirmation
  validates :email,   :presence   => true,
            :format               => { :with => email_regex },
            :uniqueness           => { :case_sensitive => false }

  validates :first_name,    :presence   => true,
            :length               => { :maximum => 30 }
  
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :last_name,    :presence   => true,
            :length               => { :maximum => 30 }
  
  
  validates :password,  :presence => true,
            :confirmation         => true,
            :length               => { :within => 4..100 }
  before_save :encrypt_password

  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private
    def encrypt_password
      self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?
      self.encrypted_password = encrypt(self.password) 
    end

    def encrypt(pass)
      Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
    end
end

