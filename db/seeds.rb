# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# -1 for unlimited plans
Plan.create(name: "Starter",emails: 1,groups: 1,agents: -1,tickets: 200,price: 0)
Plan.create(name: "For Startups",emails: 3,groups: 3,agents: -1,tickets: 500,price: 9.99)
Plan.create(name: "Small",emails: 5,groups: 5,agents: -1,tickets: 2000,price: 29.99)
Plan.create(name: "Medium",emails: 10,groups: 10,agents: -1,tickets: 10000,price: 99.99)
Plan.create(name: "Enterprise",emails: -1,groups: -1,agents: -1,tickets: 50000,price: 499.99)
company = Company.create(name: "MyCompany")
company.build_subscription(billing_period: "Monthly",company_id: 1,plan_id: 1)
company.save
["Billing","Technical","Support"].each do |group|
	company.groups.build(name: group)
	company.save
end
company.labels.create(name: "important")
company.labels.create(name: "critical")
Agent.create(
	email: "demo@helpdesk.com",password: "demo.helpdesk",password_confirmation: "demo.helpdesk",confirmed_at: Time.now,company_id: 1,
    first_name: "Demo",:last_name => "User",
    :allow_reporting => true,
    :allow_agent_management => true,
    :allow_to_invite => true,
    :allow_billing_management => true,
    :allow_company_management => true,
    :allow_subscription_management => true,
    :allow_groups_management => true
)
Agent.create(
	email: "agent1@helpdesk.com",password: "agent1.helpdesk",password_confirmation: "agent1.helpdesk",confirmed_at: Time.now,company_id: 1,
    first_name: "Agent1",:last_name => "Agent1",
    :allow_reporting => false,
    :allow_agent_management => false,
    :allow_to_invite => false,
    :allow_billing_management => false,
    :allow_company_management => false,
    :allow_subscription_management => false
)
Agent.create(
    email: "agent2@helpdesk.com",password: "agent2.helpdesk",password_confirmation: "agent2.helpdesk",confirmed_at: Time.now,company_id: 1,role: false,
    first_name: "Agent2",:last_name => "Agent2",
    :allow_reporting => true,
    :allow_agent_management => true,
    :allow_to_invite => false,
    :allow_billing_management => false,
    :allow_company_management => false,
    :allow_subscription_management => false
)
Agent.first.groups << Group.first
company.tickets.create(customer_name: "demo user",customer_email: "demo@example.com")
company.agents.first.tickets.create(customer_name: "agent user",customer_email: "agent@example.com")
company.groups.first.tickets.create(customer_name: "group user",customer_email: "group@example.com")
company.groups.first.agents.last.tickets.create(customer_name: "group & agents",customer_email: "groupsnagents@example.com")
Superadmin.create(email: "admin@helpdesk.com",password: "admin.helpdesk",password_confirmation: "admin.helpdesk",confirmed_at: Time.now)

# NOTE: Make Sure that you need to enter the new data through server's console itself.
#       Seeds will not be running with deployment.
