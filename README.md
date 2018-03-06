# TesterSorter

## Intro and Considerations 

This is a simple rails app using ruby 2.4.1 and rails  5.1.5. Due to the relatively low volume of data and the prototypical nature of the app, it is backed with sqlite3, with the intent that a more robust production version would be backed by Postgress or mySQL. An ideal version of this app would use the rails backend as an API with a React or Angular frontend making API calls to it to render data. In the interest of keeping the exercise both self contained and in scope, the project instead leverages erb for the rendering and bootstrap for the styling. The app is deployed on heroku at (url)

The assumption was made that while data was being stored in CSV this was not a long term solution and that it would make sense to have a tool to import arbitrary csvs into an existing database. The process could even run automatically on a daily basis to avoid the need to manually import the files. The importers assume that CSVs may contain old data and simply don't add it. Logs of the process are stored in log/import.log. 

The program assumes that you will have the same four files that are provided in the csv folder, formatted in the same way. It also assumes id's in the CSV file are uninque and assigns them as the ids to the records in the database. 

## Setup
This setup guide assumes that you are set up in a development enviorment with ruby, rails, and rvm already installed. If you are not, then please reference [this guide](http://railsapps.github.io/installrubyonrails-ubuntu.html)

To set this up in your local machine, follow the following steps.

First clone the repository into your folder of choice with `git clone https://github.com/thecog19/tester-finder.git`

Then navigate into the folder. Install all the gems with `bundle install`

Set up your database with `rails db:create` and `rails db:migrate` to configure the databse

The default csv files are located in `/csv`. If you wish to switch them out, do so now.

Run `rails runner csv_tasks/master.rb` to import your csv files into the database.

## Walkthrough

The app contains three major features: 

1.) A user display, that shows all users and how many bugs they have solved.

2.) A search feature, allowing the person browsing to filter the users based on device and country. 

3.) A individual display page, showing the user, the devices they own and how many bugs they've solved per device.  

## Testing

The app has a basic suite of unit tests, written in rspec run them with `bundle exec rspec`

Due to database persistance issues, you will have to run `rake db:test:prepare` before you run tests again. At the time of this writing, the models are fully tested.

## Future Features
the csv import methods should be able to handle updating data as well as importing it. 

Add indexes on external_id to allow faster readtimes and more repsonsiveness. 

Sort user show page by bugs fixed as well. 

Test csv processor.

Test controller.

Test helpers.