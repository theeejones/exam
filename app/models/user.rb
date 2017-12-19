class User < ActiveRecord::Base
  has_secure_password(validations: false)
  
  # has_many :attendances
  # has_many :events, through: :attendances, dependent: :destroy
  # has_many :hostings, :class_name => 'Event', dependent: :destroy
  # has_many :comments, dependent: :destroy

  has_many :usergroups
  has_many :groups, through: :usergroups

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }, format: { with: EMAIL_REGEX }
  validates :city, presence: true, length: { minimum: 2, maximum: 30 }
  validates :state, presence: true, length: { is: 2 }
  validates :password, presence: true, length: { minimum: 8, maximum: 50 }, on: :create
  validates_confirmation_of :password, if: :password_present
  validates_presence_of :password, on: :create

  before_save :setCase

    def setCase
      self.city = self.city.titleize
      self.state.upcase!
      self.email.downcase!
    end

    def password_present
      self.password.present?
    end
end
