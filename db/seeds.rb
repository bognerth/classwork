# -*- coding: utf-8 -*-
User.create(:email => 'bognerth@gmail.com', :password => 'password', :password_confirmation => 'password')
Group.create(name: "Lehrer")
Group.create(name: "FIT1AF")
Group.create(name: "FIT1H")
Student.create(user_id: 1,group_id: 1)
Category.create(name: "Linux Shell")
Category.create(name: "Linux Systemadministration")
Category.create(name: "Linux Server")
Course.create(name: "Fit1AF KuA ", group_id: 2)
Course.create(name: "Fit1H KuA", group_id: 3)
Test.create(description: "Test Shell",course_id: 1,category_id: 1, duration: 5)
Test.create(description: "FIT1AF Shell - Januar 2013", course_id: 1, category_id: 1, duration: 45)
Test.create(description: "FIT1H Shell - Januar 2013", course_id: 2, category_id: 1, duration: 45)
TestEvent.create(test_id: 1, state: "open")
TestEvent.create(test_id: 2, state: "new")
TestEvent.create(test_id: 3, state: "new")

