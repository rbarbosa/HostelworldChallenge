## Project Overview
This iOS application was developed as part of Hostelworld assignment to demonstrate proficiency in iOS development, API integration, and software architecture. 
The app utilizes a [test API](https://practical3.docs.apiary.io/#) to fetch properties and their details.

Key features of this implementation include:
- Networking to consume the API, including error handling
- Use of SwiftUI for building a modern UI
- Implementation of a scalable MVVM architecture
- Comprehensive unit testing with the new Swift Testing framework

## Features
- Display properties from the Gothenburg city
- Display property details
- Sort properties by ranking
- Sort properties by type (Apartment, Hostel, etc)
- Card redaction for the initial load
- Progress view when loading images and fetching property details
- Error message plus retry button when properties fetch fails
- Error alert when property details fetch fails
- App icon

## Technologies Used
- Xcode 16.1
- iOS 18.1
- SwiftUI
- Swift Concurrency
- Swift Testing

## Architecture
This project implements the Mode-View-ViewModel (MVVM) architecture in an opinionated way, i.e. inspired by [The Composable Architecture - TCA](https://github.com/pointfreeco/swift-composable-architecture), complemented by additional abstraction layers for improved scalability and testability.

The core principles of the implementation are:

- View model holds the state
- The state can only be changed through the view model and a single method - `send(_:)`
- Navigation is modeled through an enum  

Usually, I use PointFree's frameworks which helps, and improves, the ergonomics of this architecture, particularly CasePaths, SwiftNavigation.

### Additional Layers
- Repository Layer: Abstracts data sources, providing a clean API for data operations
- Networking Layer: Manages API interactions, including request construction and response handling

### Benefits of This Architecture

- Scalability: The separation of concerns allows for easy expansion of features and data sources.
- Testability: Each component can be tested in isolation, facilitating comprehensive unit testing.
- Maintainability: Clear separation of responsibilities makes the codebase easier to understand and maintain.
- Simplicity: It's easy to understand and implement new features

### Development Process

Although the git commits allow you to follow the process of building the application, here is a summary of the steps:

- For each feature, I've started with the UI with inline text values
- After the first skeleton, small improvements, like fonts and colors
- Creation of the models to hold the data needed to display
- Creation of the repositories to feed the data
- Creation of mocked responses
- Usage of mocked responses on the view/view models
- Creation of networking layer
- Add live implementation of the repositories

Regarding the features:

- Property list view
- Property details view

### Testing Framework

The project leverages the new Swift Testing framework, introduced in recent Xcode versions. 
I've started using it, and I've found, once again, this framework offers enhanced capabilities for test organization and execution, contributing to a robust testing strategy.

## Setup and Installation
After installing the Xcode, the process should be seamlessly, and the app should run without problems.

## Usage
This simple app provides properties available in the city of Gothenburg. 
After the initial loading of the properties, they are presented in a list.
On the navigation bar, there's a button for a sort menu. 
There are two options:
- sort by rating (higher rating first)
- sort by type (alphabetically)
Tapping on an option will sort the properties accordingly.

Tapping on an image, the app fetches the property details and presents a new view with the detailed information.

## Testing
This project leverages the new Swift Testing framework, introduced in recent Xcode versions, to ensure code reliability and functionality. The testing strategy focuses primarily on the models and view models, which form the core of the application's business logic.

## Future Improvements
While the current version of the app meets the assignment requirements and provides a functional user experience, there are several areas identified for future enhancement:

**User Interface and Experience**
- Layout and Design Enhancements:
  - Improve overall visual design for a more polished look
  - Optimize layouts for different device sizes and orientations
  - Localization
- Animation Improvements:
  - Enhance existing animations for smoother transitions
  - Add subtle animations to improve user feedback and engagement

**Functionality**
- Search and filter: Add functionality to search properties and filter for type, ranking, etc

**Caching**
- Caching: Implement a caching mechanism to reduce API calls (particularly for images)

**Accessibility**
- Dynamic Type: Ensure all text elements properly support Dynamic Type for improved readability



