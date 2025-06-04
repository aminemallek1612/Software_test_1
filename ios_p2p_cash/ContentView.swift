import SwiftUI

struct ContentView: View {
    @StateObject private var manager = AccountManager()

    @State private var userId = ""
    @State private var amount = ""
    @State private var receiver = ""
    @State private var message = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create Account")) {
                    HStack {
                        TextField("User ID", text: $userId)
                        Button("Create") {
                            do {
                                try manager.createAccount(userId)
                                message = "Account created"
                            } catch {
                                message = error.localizedDescription
                            }
                        }
                    }
                }

                Section(header: Text("Deposit")) {
                    TextField("User ID", text: $userId)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Button("Deposit") {
                        if let amt = Double(amount) {
                            do {
                                try manager.deposit(to: userId, amount: amt)
                                message = "Deposited \(amt) to \(userId)"
                            } catch {
                                message = error.localizedDescription
                            }
                        }
                    }
                }

                Section(header: Text("Send Money")) {
                    TextField("Sender", text: $userId)
                    TextField("Receiver", text: $receiver)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Button("Send") {
                        if let amt = Double(amount) {
                            do {
                                try manager.send(from: userId, to: receiver, amount: amt)
                                message = "Sent \(amt) from \(userId) to \(receiver)"
                            } catch {
                                message = error.localizedDescription
                            }
                        }
                    }
                }

                Section(header: Text("Balance")) {
                    TextField("User ID", text: $userId)
                    Button("Check") {
                        let bal = manager.balance(for: userId)
                        message = "Balance of \(userId): \(bal)"
                    }
                }

                if !message.isEmpty {
                    Section {
                        Text(message)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("P2P Cash App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
