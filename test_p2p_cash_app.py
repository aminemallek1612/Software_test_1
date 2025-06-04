import unittest
from p2p_cash_app import P2PCashApp


class TestP2PCashApp(unittest.TestCase):
    def setUp(self):
        self.app = P2PCashApp()
        self.app.create_account('alice')
        self.app.deposit('alice', 100)
        self.app.create_account('bob')

    def test_deposit(self):
        self.app.deposit('bob', 50)
        self.assertEqual(self.app.get_balance('bob'), 50)

    def test_send(self):
        self.app.send('alice', 'bob', 30)
        self.assertEqual(self.app.get_balance('alice'), 70)
        self.assertEqual(self.app.get_balance('bob'), 30)

    def test_insufficient(self):
        with self.assertRaises(ValueError):
            self.app.send('bob', 'alice', 10)


if __name__ == '__main__':
    unittest.main()
