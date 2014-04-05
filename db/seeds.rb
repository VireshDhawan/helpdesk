# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
<<<<<<< HEAD
#Company.create(name: "MyCompany")
Agent.create(email: "demo@helpdesk.com",password: "demo.helpdesk",password_confirmation: "demo.helpdesk",confirmed_at: Time.now)
=======
Company.create(name: "MyCompany")
Agent.create(email: "demo@helpdesk.com",password: "demo.helpdesk",password_confirmation: "demo.helpdesk",confirmed_at: Time.now,company_id: 1)
puts "------ DB Seeded-------"
>>>>>>> 8ebeae62f5908085ca7ea1e1d681b6e19cbe7989
