# BookmarkProject

The BookmarkProject is a knowledge center app. It adds some nice functionality on top of regular bookmarking, such as adding a summary, adding tags and previewing the content. 

DISCUSSION:

1. Architecture and design patterns

- I went with a modular structure of an MVVM app
- I chose to go with the SwiftUI app lifecycle because I am trying to explore and get familiarised with the new ways; In a production app I would have to make a judgement call between using this or going with an MVVM-C + UIKit lifecycle approach 
- I only use ViewModels if they need to perform actions (that's mainly if they need to make use of services), or if the View gets too large, in which case I would just move the State properties in a ViewModel
- since the app is local storage first, and the local storage model _is_ the domain model, I couldn't really showcase usage of repository/data store types, even though I would normally use them
- I prefer keeping interactions with SwiftData directly inside the Views, so I can make good use of the native APIs (mainly @Query, but also @FetchRequest if the app supports versions older than 17.0)

2. About the app

- the app is structured in three tabs: Home, New Asset, Settings 
- the "generate automatically" functionality returns dummy data 66% of the time and throws an error 33% of the time; It only serves the purpose of showcasing the functionality of the app; Implementing the backend is the next step
- I have written both UI and Unit tests (please see the app Unit Tests/UI Tests targets), but due to the randomised behaviour of the app I had to comment out some of them due to flakiness

3. Styling

- in SwiftUI I like to be able to read the body of a View at a glance; that's why I make heavy use of computed subviews; even though this approach can increase the size of the file, I think it improves legibility and some of the pitfalls can be counteracted with pragma marks (marking critical areas such as actions)

CREDITS:

- I have learned most of the techniques and patterns in this project by digging into this open source project - IceCubes - https://github.com/Dimillian/IceCubesApp   
