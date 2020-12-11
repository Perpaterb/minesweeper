## minesweeper
minesweeper ruby terminal app

https://github.com/Perpaterb/minesweeper

#### Minesweeper Development Plan


R5  Develop a statement of purpose and scope for your application. It must include:
- describe at a high level what the application will do
- identify the problem it will solve and explain why you are developing it
- identify the target audience
- explain how a member of the target audience will use it

300 - 500 words

A5
This is the classic windows game Minesweeper.

Minesweeper is a logic game where a player is shown a grid of squares with the objective to open all the squares without riding a mine under them. Each time then play the mines are in random places in the grid.

Turns out that Windows 10 doesn't come with the minesweeper by default. The aim of this terminal application is to provide entertainment and challenge players to solve the puzzle.

The target audience will be anyone wanting to solve a pimple logical puzzle without ads or get a nostalgic hit from back in the day when many working hours were wasted on Minesweeper or Solitaire. 

how to run Minesweeper 
1



R6  Develop a list of features that will be included in the application. It must include:
- at least THREE features
- describe each feature

Note: Ensure that your features above allow you to demonstrate your understanding of the following language elements and concepts:
- use of variables and the concept of variable scope
- loops and conditional control structures
- error handling
Consult with your educator to check your features are sufficient .  300 words (approx. 100 words per feature)

A6
Title screen with loading bar. The title screen shows a big logon of "minesweeper" and after the loading has finished will load straight into the main game view. 
Display grid showing the game in the terminal window.
When Game is lost the game shows the player where all the mines were in red. 
When Game is won the game shows the player where all the mines were in magenta.
The player is shown an invalid input error and given a hint when there is something wrong with their input.


#### Player interaction and experience.


After starting Minesweeper and waiting for it to load on the title screen. The player's blank grid will be displayed on the screen.  
The player will be prompted with "What grid point would you like to start at? column row eg. a1 or a 1 :".
Entering something like "d3" with their keyboard the player will submit the starting point coordinates by hitting the enter key.
The screen will be refreshed and the player will then see the updated grid on their screen.
It is impossible for the starting point to be near or on a mine.
If the player was to enter anything other than an alphabetical character from (a to i) followed by a number from (1 to 9) the input would be invalid and the program will refresh the page and give the player the error "invalid input try again:  column row eg. a1 or a 1 ``. spaces and non alphanumeric characters are removed before processing the input. so "    A   !$  && 1\n" would still return "a1" and is a valid input.
After the starting grid point has been selected and a new updated grid displayed the player to be prompted with "What grid point do you think does not have a mine?  ".
The player will repeat this process until all the non mine grid points have been revealed constituting a win or a mine grid point has been selected constituting a loss.
If the player wins, the grid is fully reliled with all the mines shown as a magenta "X".
If the player loses, the grid is fully reliled with all the mines shown as a red "X".

R8  Develop a diagram which describes the control flow of your application. Your diagram must:
- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.

A8

R9  Develop an implementation plan which:
- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item
Utilise a suitable project management platform to track this implementation plan
> Your checklists for each feature should have at least 5 items.
A9

Display grid: Priority 1
A Grid array is created. Nested in the Grid array are all the grid point arrays in row order. Each grid point array is made up of [row , column, state].
Start by printing A-I for the Column indicators.
Then run though the Grid array printing out based on the “state”. If the column is 1 then print the Increasing row indicator before it.


Invalid input error display: Priority 2
Get user input.
Take everything out of the user input that is not needed.
If 

Red X on game lost: Priority 3
Magenta “X” on game win: Priority 4
Title screen with loading: Priority 5


R10 Design help documentation which includes a set of instructions which accurately describe how to use and install the application.

You must include:
- steps to install the application
- any dependencies required by the application to operate
- any system/hardware requirements


R11 An overview of your Terminal application    The main features and overall structure of your app
R12 An overview of your code    An explanation of the important parts of your code


R13 Implement features in the software development plan you have designed. You must utilise a range of programming concepts and structures using Ruby such as:
- variables and variable scope
- loops and conditional control structures
- write and utilise simple functions
- error handling
- input and output
- importing a Ruby Gem
- using functions from a Ruby Gem
R14 Apply DRY (Don’t Repeat Yourself) coding principles to all code produced.
R15 Apply all style and conventions for the programming language consistently to all code produced.
R16 Creates an application which runs without error and has features that are consistent with the development plan.
R17 Design TWO tests which check that the application is running as expected.

Each test should:
- cover a different feature of the application
- state what is being tested
- provide at least TWO test cases and the expected results for each test case

> An outline of the testing procedure and cases should be included with the source code of the application
R18 Utilise source control throughout the development of the application by:
- making regular commits (at least 20 commits) with a commit message that summarises the changes
- pushing all commits to a remote repository
R19 Utilise developer tools to facilitate the execution of the application:
For example,
- writing a script which turns the application into an executable; OR
- packaging the application for use as a module or dependency


