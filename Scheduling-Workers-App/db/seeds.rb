# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



User.create([{
    email: 'adminn@example.com',
    password:"adminn",
    password_confirmation:"adminn",
    role: 1,
    name: "adminn",
    surname: "adminn"
}
])

Cleaner.create([{
    name: "Addetto",
    surname: "Uno",
    residence: "Uno",
    codfis: "ADDETTOUNO",
    license: "Si",
    birthdate: DateTime.new(1990,10,1),
    hired: DateTime.new(2020,10,15),
    email: " ",
    phone: " ",
    hours_required: 30,
    internaln: 1
},
{
    name: "Addetto",
    surname: "Due",
    residence: "Due",
    codfis: "ADDETTODUE",
    license: "Si",
    birthdate: DateTime.new(1990,10,1),
    hired: DateTime.new(2020,10,15),
    email: " ",
    phone: " ",
    hours_required: 30,
    internaln: 2
},
{
    name: "Addetto",
    surname: "Tre",
    residence: "Tre",
    codfis: "ADDETTOTRE",
    license: "Si",
    birthdate: DateTime.new(1990,10,1),
    hired: DateTime.new(2020,10,15),
    email: " ",
    phone: " ",
    hours_required: 30,
    internaln: 3
}
])

Site.create([
{
    nome: "Cantiere 1 S.p.a",
    time_required: 6,
    location: "Uno",
    requests: "Nessuna",
    owner: "Proprietario Uno"
},{
    nome: "Cantiere 2 S.p.a",
    time_required: 12,
    location: "Due",
    requests: "Nessuna",
    owner: "Proprietraio Due"
},{
    nome: "Cantiere 3 S.p.a",
    time_required: 2,
    location: "Due",
    requests: "Nessuna",
    owner: "Proprietraio Tre"
},{
    nome: "Cantiere 4 S.p.a",
    time_required: 1,
    location: "Due",
    requests: "Nessuna",
    owner: "Proprietraio Tre"
}
])

monday = Date.current().beginning_of_week(:monday)
tuesday = monday + 1.day
wednesday = monday + 2.day
thursday = monday + 3.day
friday = monday + 4.day

#Cantiere 1
Job.create([
{
    date: monday + 8.hours,
    duration: 2,
    cleaner_id: 1,
    site_id: 1
},
{
    date: monday + 8.hours,
    duration: 2,
    cleaner_id: 2,
    site_id: 1
},
{
    date: monday + 8.hours,
    duration: 2,
    cleaner_id: 3,
    site_id: 1
},
{
    date: tuesday + 16.hours,
    duration: 2,
    cleaner_id: 1,
    site_id: 1
},
{
    date: tuesday + 16.hours,
    duration: 2,
    cleaner_id: 2,
    site_id: 1
},
{
    date: tuesday + 16.hours,
    duration: 2,
    cleaner_id: 3,
    site_id: 1
},
{
    date: wednesday + 8.hours,
    duration: 2,
    cleaner_id: 1,
    site_id: 1
},
{
    date: wednesday + 8.hours,
    duration: 2,
    cleaner_id: 2,
    site_id: 1
},
{
    date: wednesday + 8.hours,
    duration: 2,
    cleaner_id: 3,
    site_id: 1
},
{
    date: thursday + 16.hours,
    duration: 2,
    cleaner_id: 1,
    site_id: 1
},
{
    date: thursday + 16.hours,
    duration: 2,
    cleaner_id: 2,
    site_id: 1
},
{
    date: thursday + 16.hours,
    duration: 2,
    cleaner_id: 3,
    site_id: 1
},
{
    date: friday + 8.hours,
    duration: 2,
    cleaner_id: 1,
    site_id: 1
},
{
    date: friday + 8.hours,
    duration: 2,
    cleaner_id: 2,
    site_id: 1
},
{
    date: friday + 8.hours,
    duration: 2,
    cleaner_id: 3,
    site_id: 1
}
])

#Cantiere 2
Job.create([
{
    date: monday + 12.hours,
    duration: 4,
    cleaner_id: 1,
    site_id: 2
},{
    date: monday + 12.hours,
    duration: 4,
    cleaner_id: 2,
    site_id: 2
},{
    date: monday + 12.hours,
    duration: 4,
    cleaner_id: 3,
    site_id: 2
},
{
    date: tuesday + 8.hours,
    duration: 4,
    cleaner_id: 1,
    site_id: 2
},{
    date: tuesday + 8.hours,
    duration: 4,
    cleaner_id: 2,
    site_id: 2
},{
    date: tuesday + 8.hours,
    duration: 4,
    cleaner_id: 3,
    site_id: 2
},
{
    date: wednesday + 12.hours,
    duration: 4,
    cleaner_id: 1,
    site_id: 2
},{
    date: wednesday + 12.hours,
    duration: 4,
    cleaner_id: 2,
    site_id: 2
},{
    date: wednesday + 12.hours,
    duration: 4,
    cleaner_id: 3,
    site_id: 2
}
])

#Cantiere 3
Job.create([
{
    date: monday + 16.hours,
    duration: 4,
    cleaner_id: 1,
    site_id: 3
},{
    date: monday + 16.hours,
    duration: 4,
    cleaner_id: 2,
    site_id: 3
},{
    date: monday + 16.hours,
    duration: 1,
    cleaner_id: 3,
    site_id: 4
},
{
    date: friday + 16.hours,
    duration: 4,
    cleaner_id: 1,
    site_id: 3
},{
    date: friday + 16.hours,
    duration: 4,
    cleaner_id: 2,
    site_id: 3
},
#Site Duration Constraint Violation
{
    date: friday + 16.hours,
    duration: 0.75,
    cleaner_id: 3,
    site_id: 4
},
#Temporal Constraint Violation
{
    date: monday + 16.hours + 30.minutes,
    duration: 1,
    cleaner_id: 3,
    site_id: 4
},
#Starting Minutus Violation
{
    date: wednesday + 16.hours + 17.minutes,
    duration: 1,
    cleaner_id: 3,
    site_id: 4
}
])