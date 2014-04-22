# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# -1 for unlimited plans
Superadmin.create(email: "admin@helpdesk.com",password: "admin.helpdesk",password_confirmation: "admin.helpdesk",confirmed_at: Time.now)

# NOTE: Make Sure that you need to enter the new data through server's console itself.
#       Seeds will not be running with deployment.
