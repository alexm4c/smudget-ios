README.TXT

Smudget
The Small Budget Planner

Created by Alex Mc Bain on 4/04/2016.
Copyright © 2016 Alex Mc Bain. All rights reserved.

Smudget is designed to be a lightweight budget planner aimed at students and travelers. It allows the user to create simple budgets that simply hold two lists, incomes and expenses.
The app also allows the user to convert there budget into a different currency base, allowing users to check there budget against a different currency, for if they’re travelling or something.


Assessment help:

a. Adaptive Layout
- Should work on just about all geometries, but you can never really say ALL.
- A safe bet would be iPhone 6s P+L and iPad P+L.

b. App Extension
- See the BudgetInfoToday group
- Data is hard coded :( but that only because I left this bit too late
- I managed to get a student dev account through RMIT
- but I didn't realise it was REALLY silly and I have to get in touch with beau again to get an app group or something

c. Data Persistence
- Code associated with data persistence is within BudgetModelManager
- BudgetModelManager is used in BudgetViewController and AppDelegate

d. Remote Data Access
- Code that does the API call stuff is in CurrencyModel
- CurrencyModel is used in the BudgetVC

e. iOS Framework
- I’m using a framework called Charts for this feature.
- Charts makes pretty graphs and I use it to graph the users budget.
- The code associated is in the PieChartViewController

f. Unit Tests
- Done, see the SmudgetTests group

g. Extra feature
- Don't know... learnt loads of stuff not in the lectures, but no one BIG thing
- OH, probably the picker view might count, used to select the base currency in BudgetVC
- It's a bit of a hack job but it works
- Also the 3rd Party Charts library