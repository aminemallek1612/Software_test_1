import XCTest
@testable import ios_p2p_cash

final class AccountManagerTests: XCTestCase {
    func testDepositAndSend() throws {
        let manager = AccountManager()
        try manager.createAccount("alice")
        try manager.deposit(to: "alice", amount: 100)
        try manager.createAccount("bob")
        try manager.send(from: "alice", to: "bob", amount: 40)
        XCTAssertEqual(manager.balance(for: "alice"), 60)
        XCTAssertEqual(manager.balance(for: "bob"), 40)
    }

    func testInsufficientFunds() throws {
        let manager = AccountManager()
        try manager.createAccount("alice")
        XCTAssertThrowsError(try manager.send(from: "alice", to: "bob", amount: 10))
    }
}
