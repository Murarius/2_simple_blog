# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(name: 'test', email: 'test@test.pl', password: 'test1234', password_confirmation: 'test1234')
user.posts.create!(title: 'UT MAGNA NULLA, FERMENTUM',
                   content: "Phasellus vel urna pretium, bibendum purus sit amet, lacinia sem. Nulla facilisi.
                            Nullam sapien nisl, hendrerit ut lacinia sit amet, hendrerit non nibh. Aenean
                            tempor in lectus aliquam placerat. Donec placerat vestibulum ex, sed condimentum
                            sapien placerat vel. Nullam at lorem in diam maximus ultrices. Integer consequat,
                            nisi vel sodales auctor, nisi felis euismod augue, sed semper ante nulla id quam.
                            Suspendisse potenti.",
                   more_content: "Phasellus vel urna pretium, bibendum purus sit amet, lacinia sem. Nulla facilisi.
                             Nullam sapien nisl, hendrerit ut lacinia sit amet, hendrerit non nibh. Aenean
                             tempor in lectus aliquam placerat. Donec placerat vestibulum ex, sed condimentum
                             sapien placerat vel. Nullam at lorem in diam maximus ultrices. Integer consequat,
                             nisi vel sodales auctor, nisi felis euismod augue, sed semper ante nulla id quam.
                             Suspendisse potenti.")
