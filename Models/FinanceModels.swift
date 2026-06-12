import Foundation

// MARK: - Finance Entry (for daily transactions)
struct FinanceEntry: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var type: TransactionType // income, expense
    var category: FinanceCategory
    var date: Date
    var notes: String?
    
    enum TransactionType: String, Codable {
        case income, expense
    }
    
    enum FinanceCategory: String, Codable, CaseIterable {
        case food, transport, entertainment, education, utilities, health, other
    }
}

// MARK: - Savings Account
struct SavingsAccount: Identifiable, Codable {
    let id: UUID
    var name: String // "Emergency Fund", "House Down Payment", etc.
    var targetAmount: Double
    var currentAmount: Double
    var color: String // hex color
    var startDate: Date
    var targetDate: Date?
    var notes: String?
    
    var progress: Double {
        guard targetAmount > 0 else { return 0 }
        return (currentAmount / targetAmount) * 100
    }
    
    var remainingAmount: Double {
        max(0, targetAmount - currentAmount)
    }
    
    var isCompleted: Bool {
        currentAmount >= targetAmount
    }
    
    init(name: String, targetAmount: Double) {
        self.id = UUID()
        self.name = name
        self.targetAmount = targetAmount
        self.currentAmount = 0
        self.color = Self.randomColor()
        self.startDate = Date()
        self.targetDate = nil
    }
    
    static func randomColor() -> String {
        let colors = ["FF6B6B", "4ECDC4", "45B7D1", "FFA07A", "98D8C8", "F7DC6F", "BB8FCE", "85C1E2"]
        return colors.randomElement() ?? "4ECDC4"
    }
}

// MARK: - Holiday Pot (for saving towards holidays/trips)
struct HolidayPot: Identifiable, Codable {
    let id: UUID
    var destination: String // "Paris Trip", "Summer Holiday", etc.
    var targetAmount: Double
    var currentAmount: Double
    var tripDate: Date
    var notes: String?
    
    var daysUntilTrip: Int {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: Date(), to: tripDate).day ?? 0
        return max(0, days)
    }
    
    var estimatedDailyNeeded: Double {
        guard daysUntilTrip > 0 else { return 0 }
        return (targetAmount - currentAmount) / Double(daysUntilTrip)
    }
    
    var remainingAmount: Double {
        max(0, targetAmount - currentAmount)
    }
    
    var progress: Double {
        guard targetAmount > 0 else { return 0 }
        return (currentAmount / targetAmount) * 100
    }
    
    var isCompleted: Bool {
        currentAmount >= targetAmount
    }
    
    init(destination: String, targetAmount: Double, tripDate: Date) {
        self.id = UUID()
        self.destination = destination
        self.targetAmount = targetAmount
        self.currentAmount = 0
        self.tripDate = tripDate
    }
}

// MARK: - Target Goal (financial milestone)
struct TargetGoal: Identifiable, Codable {
    let id: UUID
    var title: String // "Buy a car", "Save for wedding", etc.
    var description: String?
    var targetAmount: Double
    var currentAmount: Double
    var category: GoalCategory
    var targetDate: Date
    var priority: Priority
    var milestones: [Milestone]
    var createdDate: Date
    
    enum GoalCategory: String, Codable, CaseIterable {
        case car, home, education, wedding, vacation, investment, other
        
        var icon: String {
            switch self {
            case .car: return "car.fill"
            case .home: return "house.fill"
            case .education: return "book.fill"
            case .wedding: return "heart.fill"
            case .vacation: return "airplane"
            case .investment: return "chart.line.uptrend.xyaxis"
            case .other: return "target"
            }
        }
    }
    
    enum Priority: String, Codable {
        case low, medium, high, critical
    }
    
    struct Milestone: Identifiable, Codable {
        let id: UUID
        var title: String
        var targetAmount: Double
        var isCompleted: Bool
        var completedDate: Date?
    }
    
    var progress: Double {
        guard targetAmount > 0 else { return 0 }
        return (currentAmount / targetAmount) * 100
    }
    
    var remainingAmount: Double {
        max(0, targetAmount - currentAmount)
    }
    
    var daysRemaining: Int {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: Date(), to: targetDate).day ?? 0
        return max(0, days)
    }
    
    var monthlyRequiredSavings: Double {
        guard daysRemaining > 0 else { return 0 }
        let months = Double(daysRemaining) / 30.0
        return remainingAmount / months
    }
    
    var isCompleted: Bool {
        currentAmount >= targetAmount
    }
    
    init(title: String, targetAmount: Double, targetDate: Date, category: GoalCategory) {
        self.id = UUID()
        self.title = title
        self.targetAmount = targetAmount
        self.currentAmount = 0
        self.category = category
        self.targetDate = targetDate
        self.priority = .medium
        self.milestones = []
        self.createdDate = Date()
    }
}

// MARK: - Budget (for spending limits)
struct Budget: Identifiable, Codable {
    let id: UUID
    var category: FinanceEntry.FinanceCategory
    var limit: Double
    var spent: Double = 0
    var month: Date // tracks which month
    
    var remaining: Double {
        max(0, limit - spent)
    }
    
    var percentageUsed: Double {
        guard limit > 0 else { return 0 }
        return (spent / limit) * 100
    }
    
    var isOverBudget: Bool {
        spent > limit
    }
    
    init(category: FinanceEntry.FinanceCategory, limit: Double) {
        self.id = UUID()
        self.category = category
        self.limit = limit
        self.month = Date()
    }
}
