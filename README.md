# My Mind
 
### User Interface

Interface support iPhone only. Only portrait mode is supported

###  What you can Do in the APP 

- User could navigate to different catgories listed on Category.json file. 
- On tapping any category all the recent news feeds will appear based on the category.
- User could see the details of the news feeds. 
- Also could follow and unfollow the category. 


###   Error Handling

Error massage is added to the required places. Mostly on API failures and parsing failures. 
There are still option of improvements.


###   Branding & Colors

Brand properties are implemented to change the theme easily. 

###   Libraries

No thirdparty library is used in this project. 

###  Unit and UI Tests

Basic unit tests are added. 
I have added some advanced unit test just to explain how we can levarage the Unit test functionality over UI test which is more time consuming.
Some Basic UI test is added to verify the app flow.

# Please Note

This is a very basic app created for the assignment. I am using a open API from https://rapidapi.com/, so data might not be accurate. 
There is a limit on the api calls as well. If the limit runs out, you can test the app through local data, 

>  `return true ` from  ` BuildConfig.loadFromLocalJson `

Lastly,  the desired functionality was never given to me so I tried to make it as interactive as possible within the design scope.


# Scope of improvements

###  Jenkins and Fastlane is used for CI CD. Created a pipeline to support 
###  Crashlytics and Error Handling
###  Firebase analytics can be used and successfully tracking events 



