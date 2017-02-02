# README

INTRO

Name - "SHEQ_APPS"

It is intended to develop prototype applications for information and workflow 
management within the Safety, Health, Environment and Quality function.

Information used in this development environment to seed the database must not
include any company specific information.

This App is developed by Andrew Hampson (SHEQ Manager at Tradebe Inutec, 2016)
andrewhampson6@gmail.com

PURPOSE

Tracking, reporting and administration of various related SHEQ functions is 
currently achieved through separated databases and spreadsheets. This is labour 
intensive and inefficient in the application of SHEQ team time. Also there is a 
lack of USER ENGAGEMENT, DATA VISIBILITY, and ACCOUNTABILITY in the current SHEQ
processes.

SHEQ_APPS seeks to provide a single point interface for staff, managers, SHEQ 
and administration to manage the SHEQ processes. This application if successful
will be hosted locally on the company intranet.

FRAMEWORK

* Rails version - 5.0.0.1
* Ruby version - 2.3.0


SETUP

* System dependencies

Gems: in addition to core Rails gems

* bcrypt',        '3.1.11'
* 'bootstrap-sass', '3.3.6'
* 'gon'
* 'roo', "~> 2.7.0"
* 'chartkick'

Remember to run : bundle install

* Configuration

* Database creation

run : rails db:migrate

* Database initialization

If in development environment seed the db using the Faker gem.

run : rails db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

This is now a viable application for user testing.

Version 0.0.0

