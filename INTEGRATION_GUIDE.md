# Daily Routine App - Complete Integration Guide

## 📱 Project Overview

A comprehensive iOS app for personal life management, built with SwiftUI and Core Data. Features include daily routines, reminders, calendar events, life goals, advanced finance tracking (savings, holiday pots, target goals), and university/academic management.

---

## 🎯 Features

### 1. **Daily Routine** ⏰
- Track morning routines (wake up, breakfast, exercise, etc.)
- Set durations and automatic reminders
- Mark routines as completed
- Visual progress tracking

### 2. **Reminders** 🔔
- Create one-time or recurring reminders
- Daily, weekly, monthly, yearly options
- Custom notification times
- Enable/disable reminders easily

### 3. **Calendar & Events** 📅
- Add events with start/end times
- All-day event support
- Event types: Work, Personal, Birthday, Holiday, Appointment
- Location tracking
- Graphical date picker

### 4. **Life Goals** 🎯
- 6 categories: Health, Career, Education, Financial, Personal, Hobby
- 4 priority levels: Low, Medium, High, Critical
- Progress tracking with circular visualizations
- Milestones for major goals
- Target dates

### 5. **Finance Management** 💰
- **Transactions**: Income and expense tracking with categories
- **Savings Accounts**: Multiple savings goals with color-coded progress
- **Holiday Pots**: Plan vacations with daily savings calculations
- **Target Goals**: Major financial milestones (car, home, wedding, etc.)
- **Budgets**: Monthly spending limits per category
- Dashboard with key metrics

### 6. **University/Academic** 📚
- **Courses**: Track courses, credits, grades, instructor info
- **Assignments**: Due dates, submission tracking, grading
- **Exams**: Schedule, locations, exam preparation
- Course filtering and summary statistics

---

## 🛠️ Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Database**: Core Data
- **Notifications**: UserNotificationCenter
- **Analytics**: Firebase Crashlytics (optional)

---

## 📁 Project Structure

```
DailyRoutineApp/
├── App/
│   ├── YourAppApp.swift          # Main app entry
│   └── AppDelegate.swift          # App lifecycle
├── Models/
│   ├── FinanceModels.swift        # Finance data structures
│   ├── CoreDataFinanceModels.swift # Core Data entities
│   └── (Other models)
├── Services/
│   ├── DatabaseService.swift      # Core Data operations
│   ├── FinanceDatabaseService.swift # Finance CRUD ops
│   └── NotificationService.swift  # Notification management
├── Views/
│   ├── MainTabView.swift          # Tab navigation
│   ├── RoutineView.swift
│   ├── RemindersView.swift
│   ├── EventsView.swift
│   ├── GoalsView.swift
│   ├── FinanceView.swift
│   └── UniversityView.swift
├── Tests/
│   └── DailyRoutineAppTests.swift # Unit tests
└── Resources/
    └── Assets (colors, images)
```

---

## ⚙️ Setup Instructions

### Step 1: Create Core Data Model

1. In Xcode: **File → New → Data Model**
2. Name it `DailyRoutineApp.xcdatamodeld`
3. Create entities matching `CoreDataFinanceModels.swift`:
   - RoutineEntity
   - ReminderEntity
   - EventEntity
   - LifeGoalEntity
   - FinanceEntryEntity
   - SavingsAccountEntity
   - HolidayPotEntity
   - TargetGoalEntity
   - BudgetEntity
   - UniversityCourseEntity
   - AssignmentEntity
   - ExamEntity

### Step 2: Add Required Capabilities

1. **Notifications**: 
   - Project Settings → Signing & Capabilities → + Capability
   - Add "Push Notifications"

2. **Background Modes** (optional):
   - Add "Background Fetch"

### Step 3: Request Notification Permissions

In your app's first launch, request notification permissions:

```swift
NotificationService.shared.requestNotificationPermission { granted in
    if granted {
        print("✅ Notifications enabled")
    }
}
```

### Step 4: Initialize Database Service

```swift
@StateObject var dbService = DatabaseService.shared
```

This automatically initializes Core Data and loads all data.

---

## 🚀 Usage Examples

### Add a Routine

```swift
let routine = RoutineItem(title: "Wake up", time: Date(timeIntervalSinceNow: 28800), duration: 30)
dbService.addRoutine(routine)
NotificationService.shared.scheduleRoutineNotification(for: routine)
```

### Add a Finance Entry

```swift
let entry = FinanceEntry(
    id: UUID(),
    title: "Lunch",
    amount: 15.50,
    type: .expense,
    category: .food,
    date: Date(),
    notes: nil
)
dbService.addFinanceEntry(entry)
```

### Create a Savings Goal

```swift
var savings = SavingsAccount(name: "Emergency Fund", targetAmount: 5000)
savings.targetDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
dbService.addSavingsAccount(savings)
```

### Plan a Holiday

```swift
let tripDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())!
let holiday = HolidayPot(destination: "Paris", targetAmount: 3000, tripDate: tripDate)
dbService.addHolidayPot(holiday)
```

### Set a Financial Goal

```swift
let futureDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
let goal = TargetGoal(
    title: "Buy a Car",
    targetAmount: 25000,
    targetDate: futureDate,
    category: .car
)
goal.priority = .high
dbService.addTargetGoal(goal)
```

### Add a Course

```swift
let course = UniversityCourse(
    id: UUID(),
    name: "Data Structures",
    code: "CS201",
    instructor: "Dr. Johnson",
    credits: 4,
    schedule: [],
    currentGrade: nil
)
dbService.addCourse(course)
```

---

## 🧪 Testing

Run unit tests with:
```bash
⌘U (or Product → Test)
```

**Test Coverage**:
- FinanceEntry calculations
- SavingsAccount progress tracking
- HolidayPot daily savings needed
- TargetGoal monthly requirements
- Budget overage detection
- Routine creation and icons
- Event duration calculations
- Goal priority ordering
- Course grade management
- Assignment submission status

---

## 📊 Database Operations

### CRUD Operations

All CRUD (Create, Read, Update, Delete) operations are handled by `DatabaseService`:

```swift
// Create
dbService.addRoutine(routine)
dbService.addReminder(reminder)
dbService.addEvent(event)
dbService.addGoal(goal)
dbService.addFinanceEntry(entry)
dbService.addSavingsAccount(account)
dbService.addHolidayPot(pot)
dbService.addTargetGoal(goal)
dbService.addBudget(budget)
dbService.addCourse(course)
dbService.addAssignment(assignment)
dbService.addExam(exam)

// Read (Automatic via @Published properties)
@EnvironmentObject var dbService: DatabaseService
let routines = dbService.routines

// Update
dbService.updateRoutine(updatedRoutine)
dbService.updateFinanceEntry(updatedEntry)

// Delete
dbService.deleteRoutine(id)
dbService.deleteFinanceEntry(id)
```

### Data Persistence

All data is automatically saved to Core Data. No manual save calls needed - just update the model and call the service method.

---

## 🔔 Notifications

### Schedule Routine Notification

```swift
NotificationService.shared.scheduleRoutineNotification(for: routine)
```

### Schedule Reminder

```swift
NotificationService.shared.scheduleNotification(for: reminder)
```

### Assignment Due Reminder

```swift
guard let course = dbService.courses.first(where: { $0.id == assignment.courseId }) else { return }
NotificationService.shared.scheduleAssignmentDueReminder(for: assignment, courseName: course.name)
```

### Exam Reminder

```swift
guard let course = dbService.courses.first(where: { $0.id == exam.courseId }) else { return }
NotificationService.shared.scheduleExamReminder(for: exam, courseName: course.name)
```

---

## 🎨 UI Customization

### Colors

Edit colors in each view or create a theme file:

```swift
extension Color {
    static let appBlue = Color(red: 0.2, green: 0.4, blue: 0.8)
    static let appGreen = Color(red: 0.2, green: 0.8, blue: 0.4)
    // ... more colors
}
```

### Fonts

Use SwiftUI's built-in font modifiers:

```swift
Text("Title")
    .font(.headline)
    .fontWeight(.bold)
```

---

## 📈 Performance Tips

1. **Lazy Loading**: Use `.lazy` in Lists for large datasets
2. **Image Optimization**: Compress images before adding
3. **Core Data Batching**: For bulk operations, batch them together
4. **Memory Management**: The app uses weak references where appropriate

---

## 🐛 Debugging

### Enable Core Data Debug Logging

Add launch argument in Xcode Scheme:
```
-com.apple.CoreData.SQLDebug 1
```

### Check Pending Notifications

```swift
NotificationService.shared.getPendingNotifications { requests in
    print("Pending notifications: \(requests.count)")
}
```

### View Database Location

```swift
let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
print("Documents folder: \(documents[0])")
```

---

## 📱 Device Compatibility

- **Minimum iOS**: 15.0
- **Target iOS**: 17.0+
- **iPhone Models**: iPhone 12 and later (tested on iPhone 17)
- **iPad**: Also supported with optimized layouts

---

## 🔐 Privacy & Security

- **Local Storage Only**: All data stored locally on device
- **No Cloud Sync**: By default, data doesn't sync across devices
- **Encryption**: Core Data with file protection
- **Permissions**: Only requests notification permissions

To add iCloud sync, enable CloudKit in capabilities and modify DatabaseService.

---

## 📝 Common Issues & Solutions

### Issue: Notifications not appearing
**Solution**: 
1. Check if notifications are enabled in Settings
2. Ensure `requestNotificationPermission()` was called
3. Verify notification trigger is set correctly

### Issue: Core Data crashes
**Solution**:
1. Check entity names match in data model
2. Verify all @NSManaged properties are declared
3. Clear app data and rebuild

### Issue: UI not updating
**Solution**:
1. Ensure you're using `@EnvironmentObject` for DatabaseService
2. Verify `@Published` properties are correct
3. Use `DispatchQueue.main.async` for UI updates

---

## 🚢 Deployment

### Before App Store Submission

1. ✅ Test on physical device
2. ✅ Enable crash reporting (Firebase)
3. ✅ Add app icon and launch screen
4. ✅ Write privacy policy
5. ✅ Create compelling screenshots
6. ✅ Test all features thoroughly
7. ✅ Add app description and keywords

### Submit to App Store

1. In Xcode: **Product → Archive**
2. Open **Organizer** and select your archive
3. Click **Distribute App**
4. Choose **App Store Connect** distribution
5. Complete the submission process

---

## 📚 Resources

- [SwiftUI Documentation](https://developer.apple.com/xcode/swiftui/)
- [Core Data Guide](https://developer.apple.com/documentation/coredata)
- [UserNotifications](https://developer.apple.com/documentation/usernotifications)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)

---

## 📝 License

This project is personal-use software. You can modify and distribute as needed.

---

## 🤝 Contributing

Feel free to extend this app with:
- Photo/media storage
- Data export (CSV, PDF)
- Habits tracking
- Health integration
- Social sharing features
- Dark mode optimization

---

## 📞 Support

For questions or issues, refer to the inline code documentation and Xcode Quick Help.

---

**Happy coding! 🎉 Build something amazing! 🚀**
