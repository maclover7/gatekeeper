class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner

  validates_uniqueness_of :email

  def admin!
    self.admin = true
    self.save!
  end

  def admin?
    admin == true
  end

  ## ONLY UNCOMMENT THE BELOW CODE IF A DATA
  # MIGRATION IS TAKING PLACe
  def password_required?
    false
  end
end
