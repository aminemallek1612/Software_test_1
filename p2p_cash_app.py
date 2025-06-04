class P2PCashApp:
    """Simple peer-to-peer cash application."""

    def __init__(self):
        # user balances stored in dictionary
        self.accounts = {}

    def create_account(self, user_id):
        if user_id in self.accounts:
            raise ValueError("Account already exists")
        self.accounts[user_id] = 0

    def deposit(self, user_id, amount):
        if amount < 0:
            raise ValueError("Amount must be positive")
        if user_id not in self.accounts:
            self.create_account(user_id)
        self.accounts[user_id] += amount

    def send(self, sender_id, receiver_id, amount):
        if amount <= 0:
            raise ValueError("Amount must be positive")
        if sender_id not in self.accounts:
            raise ValueError("Sender does not exist")
        if self.accounts[sender_id] < amount:
            raise ValueError("Insufficient funds")
        if receiver_id not in self.accounts:
            self.create_account(receiver_id)
        self.accounts[sender_id] -= amount
        self.accounts[receiver_id] += amount

    def get_balance(self, user_id):
        if user_id not in self.accounts:
            return 0
        return self.accounts[user_id]


def main():
    app = P2PCashApp()

    while True:
        cmd = input("Enter command (create, deposit, send, balance, quit): ")
        if cmd == "quit":
            break
        elif cmd == "create":
            uid = input("User ID: ")
            try:
                app.create_account(uid)
                print(f"Account for {uid} created")
            except ValueError as e:
                print("Error:", e)
        elif cmd == "deposit":
            uid = input("User ID: ")
            amount = float(input("Amount: "))
            try:
                app.deposit(uid, amount)
                print(f"Deposited {amount} to {uid}")
            except ValueError as e:
                print("Error:", e)
        elif cmd == "send":
            sender = input("Sender ID: ")
            receiver = input("Receiver ID: ")
            amount = float(input("Amount: "))
            try:
                app.send(sender, receiver, amount)
                print(f"Sent {amount} from {sender} to {receiver}")
            except ValueError as e:
                print("Error:", e)
        elif cmd == "balance":
            uid = input("User ID: ")
            print(f"Balance of {uid}: {app.get_balance(uid)}")
        else:
            print("Unknown command")


if __name__ == "__main__":
    main()
