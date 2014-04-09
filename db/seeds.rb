# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Company.create(name: "MyCompany")
Agent.create(email: "demo@helpdesk.com",password: "demo.helpdesk",password_confirmation: "demo.helpdesk",confirmed_at: Time.now,company_id: 1)
# -1 for unlimited plans
Plan.create(name: "Starter",emails: 1,groups: 1,agents: -1,tickets: 200,price: 0)
Plan.create(name: "For Startups",emails: 3,groups: 3,agents: -1,tickets: 500,price: 9.99)
Plan.create(name: "Small",emails: 5,groups: 5,agents: -1,tickets: 2000,price: 29.99)
Plan.create(name: "Medium",emails: 10,groups: 10,agents: -1,tickets: 10000,price: 99.99)
Plan.create(name: "Enterprise",emails: -1,groups: -1,agents: -1,tickets: 50000,price: 499.99)