import Foundation

class AccountManager: ObservableObject {
    enum AccountError: Error, LocalizedError {
        case accountExists
        case unknownUser
        case insufficientFunds
        case invalidAmount

        var errorDescription: String? {
            switch self {
            case .accountExists:
                return "Account already exists"
            case .unknownUser:
                return "User does not exist"
            case .insufficientFunds:
                return "Insufficient funds"
            case .invalidAmount:
                return "Amount must be positive"
            }
        }
    }

    @Published private(set) var balances: [String: Double] = [:]

    func createAccount(_ userId: String) throws {
        guard balances[userId] == nil else {
            throw AccountError.accountExists
        }
        balances[userId] = 0
    }

    func deposit(to userId: String, amount: Double) throws {
        guard amount >= 0 else { throw AccountError.invalidAmount }
        if balances[userId] == nil {
            try createAccount(userId)
        }
        balances[userId, default: 0] += amount
    }

    func send(from senderId: String, to receiverId: String, amount: Double) throws {
        guard amount > 0 else { throw AccountError.invalidAmount }
        guard let senderBalance = balances[senderId] else {
            throw AccountError.unknownUser
        }
        guard senderBalance >= amount else {
            throw AccountError.insufficientFunds
        }
        if balances[receiverId] == nil {
            try createAccount(receiverId)
        }
        balances[senderId] = senderBalance - amount
        balances[receiverId, default: 0] += amount
    }

    func balance(for userId: String) -> Double {
        return balances[userId] ?? 0
    }
}
