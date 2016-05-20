README.TXT

Smudget
The Small Budget Planner

Created by Alex Mc Bain on 4/04/2016.
Copyright © 2016 Alex Mc Bain. All rights reserved.

Smudget is designed to be a lightweight budget planner aimed at students and travelers. It allows the user to create simple budgets that simply hold two lists, incomes and expenses.
The app also allows the user to convert there budget into a different currency base, allowing users to check there budget against a different currency, for if they’re travelling or something.


Assessment help:

a. Adaptive Layout
- Should work on just about all geometries, but you never know.
- A safe bet would be iPhone 6s P+L and iPad P+L.

b. App Extension

c. Data Persistence
- Most of the code associated with data persistence is within BudgetModelManager
- BudgetModelManager is used in BudgetViewController and AppDelegate

d. Remote Data Access
- Most of the code that does the API call stuff is in CurrencyModel
- the CurrencyModel is used in BudgetVC

e. iOS Framework
- I’m using a framework called Charts for this feature.
- Charts makes pretty graphs and I use it to graph the users budget.