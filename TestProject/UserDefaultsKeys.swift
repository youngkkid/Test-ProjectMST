import Foundation


public enum StorageKeys {
    static let hasSubscription = "hasSubscription"
    static let selectedPlan = "selectedPlan" // optional
}

public enum Plan: String {
    case month
    case year
}
