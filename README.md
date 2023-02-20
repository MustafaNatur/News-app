# News app
<img src="images/logo.jpg" align="left" hspace="1" vspace="1" height="150" width="150">

#  News app

PET project: news app


---

### About
In this lab, I am asked to create an application that will, using the API, load news headlines and show them as a list.
Tap on the news from the list to go to view the full information on the selected news.

###
<table>
    <td><img src="images/1.png" width="320"></td>
    <td><img src="images/2.png" width="320"></td>
    <td><img src="images/3.png" width="320"></td>
    <td><img src="images/4.png" width="320"></td>
    <td><img src="images/5.png" width="320"></td>
</table>

## Basic requirements

* **The application must be written in Swift. Without using SwiftUI. Without using third-party libraries/hearths.**
* For UI, you can use XIB and layout code, it is not recommended to use Storyboard.
* The minimum supported version of the app is iOS 14.
* Upload no more than 20 news items at a time.
* Provide for the possibility of updating the news list.
* Each cell should display:
  * title,
  * picture,
* number of content views (transitions to the news details screen).
* When you click on each news item, a new screen should open and show its brief contents:
  * title,
  * picture,
* description,
  * date of publication,
  * source of the publication,
  * clickable link to the full text of the news.
* The full text of the news should be opened using WebKit.
* News data (title, summary, link to the full version, etc.) and the view counter must be cached in some way.
* Cached data is displayed before sending a data update request.
* Cached data is available even after restarting the application.

## What can be improved

* Page-by-page loading of all available news with an endless feed (pagination of 20 news).
* Update the news list using the pull-to-refresh gesture.
* Exception handling. For example, the lack of an Internet connection.

### Installation

1. Clone the repo via git clone command
```
https://github.com/MustafaNatur/News-app.git
```
2. Open in Xcode
```
open NewsAppTFS.xcodeproj
```
