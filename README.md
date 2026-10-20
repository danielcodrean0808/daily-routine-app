# Daily Routine App

A work-in-progress SwiftUI app for iPhone that brings personal finance planning and life goal tracking together in one place.

> **Status: early work in progress.** This repository currently contains the data models for the finance features and the SwiftUI screens for life goals. Some types the views depend on (such as `DatabaseService` and `LifeGoal`) and the Xcode project file are not committed yet, so the code does not build on its own at the moment.

## What is in the code today

### Finance models (`Models/FinanceModels.swift`)
- **Transactions** (`FinanceEntry`): income or expense entries with categories (food, transport, entertainment, education, utilities, health, other).
- **Savings accounts** (`SavingsAccount`): a target amount, current amount, optional target date, progress, remaining amount and a completed flag.
- **Holiday pots** (`HolidayPot`): saving towards a trip, with days until the trip and an estimated amount to save per day.
- **Target goals** (`TargetGoal`): bigger savings goals (car, home, education, wedding, vacation, investment, other) with priorities and milestones.
- **Budgets** (`Budget`): a monthly limit per category, with amount remaining, percentage used and an over-budget check.

All models are `Identifiable` and `Codable`.

### Life goals screens (`Views/GoalsView.swift`)
- A list of life goals with an empty state and an "Add Goal" button.
- Filtering goals by category.
- Swipe to delete a goal.
- A circular progress indicator for each goal.
- Forms to add and edit a goal: title, description, category, priority and an optional target date.

## Tech stack
- Swift
- SwiftUI (`NavigationStack`, forms, pickers, date pickers)
- Foundation `Codable` models

## Requirements
- A Mac with Xcode (a recent version that supports iOS 16 or later, since the views use `NavigationStack`)
- An iPhone or the iOS Simulator

## How to build in Xcode
Because the Xcode project is not in the repository yet:
1. Open Xcode and create a new iOS App project using SwiftUI.
2. Clone this repository and drag the `Models` and `Views` folders into the project.
3. Add the missing pieces the views need (a `DatabaseService` `ObservableObject` with a `goals` array, and a `LifeGoal` model) or wait until they are committed here.
4. Choose an iPhone simulator and press Run (Cmd + R).

## Screenshots
Screenshots will be added here once the app builds and runs.

<!-- ![Goals screen](docs/screenshots/goals.png) -->

## Roadmap
- Commit the Xcode project, `DatabaseService` and `LifeGoal` so the app builds from a fresh clone
- Add finance screens that use the existing models
- Add unit tests

## Author
Daniel Codrean, Computer Science student at UCLan.
