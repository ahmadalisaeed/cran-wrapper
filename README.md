# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.6.2

* System dependencies
  Docker Composer

* Configuration
  `docker-compose build`

* Database creation
  `docker-compose run web rails db:create`

* Database initialization
  `docker-compose run web rails db:migrate`

* How to run the test suite
  `docker-compose run web rspec`

* How to start the server
  `docker-compose up`

* Routes
  `http://localhost:5000/admin/sidekiq/recurring-jobs` to See the Recurring Jobs
  `http://localhost:5000/admin` to See the indexed packages
