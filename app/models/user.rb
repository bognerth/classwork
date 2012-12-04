class User < ActiveRecord::Base
  #attr_accessible :email, :password_hash, :password_salt
  attr_accessible :email, :password, :password_confirmation

  validates_uniqueness_of :email
	validates :email, :presence => true, :email_format => true

  has_secure_password

  has_one :student
  #accepts_nested_attributes_for :student

  after_create :send_mail

  protected

  def send_mail
  	UserMailer.new_user.deliver
  end

end
