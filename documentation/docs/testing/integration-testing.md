---
sidebar_position: 2
---
# Integration tests

Tests to demonstrate each use-case based on the use-case descriptions and the sequence diagrams. External input should be provided via mock objects and results verified via mock objects. Integration tests should not require manual entry of data nor require manual interpretation of results.

# Use Case 1 - Account Login

A user wants to login into their account

1. The user is presented with the login page.
2. The user clicks the 'Login with Apple Account' button.
3. The user enters their account info.
4. The server verified the account.
5. The user is able to continue into the app.

## Assertion

1. After the user logins to the app, they will be routed to the Home Page
2. The user's information will be cached onto the phones storage to retain login information for next time they open the app.
