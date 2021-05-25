# TST Google Sheets Model

## Setup
1. `bundle install`
1. `bundle exec figaro install`
1. Go to [Google Developers Console](console.cloud.google.com) and follow these steps:  
    - Create a new project (from the account that holds the sheets)
    - Go to APIs and Services -> Library
    - Enable Google Drive API and Google Sheets API 
    - Go to APIs and Services -> Credentials
    - Click 'CREATE CREDENTIALS' -> Help me choose 
    - Choose:
      -  Google Sheets API 
      -  User data 
      -  Complete app info 
      -  Add scopes: User Info, Drive and Sheets 
      -  Application Type: Web Application 
      -  Redirect URI: `http://localhost:3000/`
      -  Click Create Credentials 
      -  Save Client ID and Client secret
1. Within `config/application.yml`, define the following environment variables: 
```zsh
GOOGLE_CLIENT_ID: <YOUR_CLIENT_ID>  
GOOGLE_CLIENT_SECRET: <YOUR_CLIENT_SECRET>  
SUPER_SECRET_TOKEN: <SUPER_SECRET_TOKEN> # this is used for stubbing requests in tests

GOOGLE_SPREADSHEET_IDS:  
  - ["<NAME 1>", <SPREADSHEET_ID_1>]
  - ["<NAME 2>", <SPREADSHEET_ID_2]
  - [etc.]
```
