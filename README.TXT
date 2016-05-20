README.TXT

Smudget: The Small Budget Planner

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
- but I didn't realise it was REALLY silly and I have to get in touch with beau again to get my App ID signed up

c. Data Persistence
- Code associated with data persistence is within BudgetModelManager
- BudgetModelManager is used in BudgetViewController and AppDelegate

d. Remote Data Access
- Code that does the API call stuff is in CurrencyModel
- CurrencyModel is used in the BudgetVC

e. iOS Core Framework
- For this bit I came up with a really dumb solution.
- Originally I was going let the user take pictures of recipts
- But storing those in CoreData was going to be a pain, I also don't have an iPhone to demo/test
- So now I've just added a little easter egg on the ExistingBudgetViewController
- When you shake the device on the ExistingBVC, all of your budgets are shuffled, LOL.

f. Unit Tests
- Done, see the SmudgetTests group

g. Extra feature
- Don't know... learnt loads of stuff not in the lectures, but no one BIG thing
- OH, probably the picker view might count, used to select the base currency (see: BudgetViewController)
- It's a bit of a hack job but it works
- Also the 3rd Party Charts library (see: PieChartViewController)


References/Credits:

- I did not write the Shuffle.swift file, credits in file.
- Credit goes to all other official libraries author(s)