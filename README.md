# TesterSorter

##Intro and Considerations 
This is a simple rails app using ruby 2.4.1 and rails  5.1.5. Due to the relatively low volume of data and the prototypical nature of the app, it is backed with sqlite3, with the intent that a more robust production version would be backed by Postgress or mySQL. An ideal version of this app would use the rails backend as an API with a React or Angular frontend making API calls to it to render data. In the interest of keeping the exercise both self contained and in scope, the project instead leverages erb for the rendering and bootstrap for the styling. The app is deployed on heroku at (url)

The assumption was made that while data was being stored in CSV this was not a long term solution and that it would make sense to have a tool to import arbitrary csvs into an existing database. The process could even run automatically on a daily basis to avoid the need to manually import the files. The importers assume that CSVs may contain old data and simply don't add it. Logs of the process are stored in log/import.log. 

## Setup

To set this up in your local machine, follow the following steps.

## Testing

The app has a basic suite of unit tests, run them with

## Future Features
the csv import methods should be able to handle updating data as well as importing it. 

Add indexes on external_id to allow faster readtimes and more repsonsiveness. 