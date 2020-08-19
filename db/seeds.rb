# coding: utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             affiliation: "管理部",
             employee_number: "1",
             uid: "1",
             basic_work_time: Time.current.change(hour: 8, min: 0, sec: 0),
             designated_work_start_time: Time.current.change(hour: 8, min: 0, sec: 0),
             designated_work_end_time: Time.current.change(hour: 17, min: 0, sec: 0),
             admin: true,
             password: "password",
             password_confirmation: "password")

User.create!(name: "上長",
             email: "sample-1@email.com",
             affiliation: "管理部",
             employee_number: "2",
             uid: "2",
             basic_work_time: Time.current.change(hour: 8, min: 0, sec: 0),
             designated_work_start_time: Time.current.change(hour: 8, min: 0, sec: 0),
             designated_work_end_time: Time.current.change(hour: 17, min: 0, sec: 0),
             superior: true,
             password: "password",
             password_confirmation: "password")

10.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+2}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               affiliation: "",
               employee_number: "#{n+3}",
               uid: "#{n+3}",
               basic_work_time: Time.current.change(hour: 8, min: 0, sec: 0),
               designated_work_start_time: Time.current.change(hour: 8, min: 0, sec: 0),
               designated_work_end_time: Time.current.change(hour: 17, min: 0, sec: 0),
               password: password,
               password_confirmation: password)
end