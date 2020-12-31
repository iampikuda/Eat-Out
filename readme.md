# Eat Out  

## Introduction
`Eat out` is a simple application that visializes a list of Restaurants gotten from the JSON file, `iOS sample.JSON`, on file.

## Funtionalities
1. The Restaurants are sort based on their open status first and will stay that way regardless of what other sort option is chosen
2. The Restaurants can be further sorted by clicking on any of the sort options on the top vertical collection view
3. Restaurants can be found by typing in a case-insensitive name in the search bar at the top. 

## Installing

### Prerequisites
#### Xcode
Xcode 12 or above

### Setup Repo
1. `git clone git@github.com:iampikuda/Eat-Out.git`
2. `cd cd Eat\ Out`
3. `pod install`
4. `open open Eat\ Out.xcworkspace/`

## Pods
1. `RealmSwift`: Serves as the database
2. `SnapKit`: A wrapper to help with auto layout 
3. `SwiftLint`: A linter to keep the code clean
4. `SnapshotTesting`: A snapshot testing library

## Testing

Run `CMD+U` on XCode to run all tests. 

### Snapshot Testing
Things to note:

1. Run tests using the *iPhone 12 pro max* simulator
2. Running the test for the first time is very likely to fail. Run again.
