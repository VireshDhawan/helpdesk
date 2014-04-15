class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :validate_on_invite => true
	
	belongs_to :company
  has_many :tickets
  has_many :groups_agents, :class_name => "GroupsAgents"
  has_many :groups, :through => :groups_agents

	attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name,:last_name,:role,:signature,:api_token,
                  :company_id,:confirmed_at,:invitation_sent_at,:allow_reporting,
                  :allow_agent_management,:allow_to_invite,:allow_billing_management,
                  :allow_company_management,:allow_subscription_management

  validates :role, inclusion: { in: [true,false], message: "can't be blank" }

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
