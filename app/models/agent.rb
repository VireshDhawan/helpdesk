class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
	
	belongs_to :company

	attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name,:last_name,:role,:signature,:api_token,
                  :company_id,:confirmed_at

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  #check if the user is admin
  def is_admin?
    self.role ? true : false
  end
      
end
