class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async, :confirmable, :validate_on_invite => true
	
	belongs_to :company
  has_many :tickets
  has_many :groups_agents, :class_name => "GroupsAgents"
  has_many :groups, :through => :groups_agents
  has_many :snippets, as: :snippetable
  has_one :notification
  has_many :replies,as: :replier
  has_many :comments

	attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name,:last_name,:role,:signature,:api_token,
                  :company_id,:confirmed_at,:invitation_sent_at,:allow_reporting,
                  :allow_agent_management,:allow_to_invite,:allow_billing_management,
                  :allow_company_management,:allow_subscription_management,
                  :allow_groups_management

  validates :role, inclusion: { in: [true,false], message: "can't be blank" }

  # scope for group tickets for a agent
  def all_group_tickets
    groups.map { |g| g.tickets }.flatten
  end

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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.get_list(company)
    company.agents.collect{ |a| [a.full_name, a.id] }
  end

end
