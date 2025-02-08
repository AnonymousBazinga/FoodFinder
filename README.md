# Food Finder

## Student Information
Name: Pranav Madhukar

CSE netid: pranavcm

email: pranavcm@uw.edu

## Design Vision
Tell us about what your design vision was.
 - Functionally
 - Aesthetically
 - How are you nudging people toward patios on sunny days? Please provide us with a file name and line number where we can find this implemented

Where in your repo can we find the sketches that you made?

If your final design changed from your initial sketches please explain what changed and why.

So my initial design vision was "Tinder for Food", where you can swipe right on food you like, swipe left on things you do not like and it curates your feed. However, as I began to implement this I realized there were some challenges to this design.

Most notably, I realized that the tinder swipe interface is very complex. It has the card rotate a bit, some amount of manual free control over the card etc. That was too hard to implement, and I tried searching for packages to help but I could not find anything of the same level. So I simply decided to use Dismissable widgets which have an inbuilt swipe functionality (although no rotation).

Functionally, I also simplified the cart summary page by making it using List builder view rather than containers or boxes with the information.

On sunny days, I include a short text header reminding people to look at the restaurants with Patios (line 108, cart_summary.dart). For the list of all the restaurants the user added to the cart, I also include a grill icon indicating if it contains a Patio or not (line 71, cart_summary.dart)

The sketches are in the assets folder.


## Resources Used

1. I used the JSON data from this website - https://pad.riseup.net/p/bjLZPwQGUnzvbpFwtfna-keep
2. I used the flutter docs on GestureDetector that I used for the cart button - https://api.flutter.dev/flutter/widgets/GestureDetector-class.html?gad_source=1&gclid=CjwKCAjw-JG5BhBZEiwAt7JR610kMk7xZ8A8iF9Dc-meQ3ns1KqKaBBKvsEF9GzrIEVsKdpCb8aApRoCN0MQAvD_BwE&gclsrc=aw.ds
3. I used this link to learn about Dismissable widgets - https://www.geeksforgeeks.org/flutter-dismissible-widget/

## Reflection Prompts

### New Learnings
What new tools, techniques, or other skills did you learn while doing this assignment?

I think my biggest learning in this assignment was gaining a lot of familiarity with the concepts from previous assignments - especially providers, setting state etc.

A new tool that I learnt doing this assignment was gesture detectors which are extremely useful and can almost act like eventListeners from web programming.

How do you think you might use what you learned in the future?

Any sort of application that requires user interactivity beyond very basic forms will require gesture detectors - whether it is double tap, regular tap, panning, holding the screen etc.

## Challenges
What was hard about doing this assignment?
What did you learn from working through those challenges?
How could the assignment be improved for future years?

I struggled quite hard to implement the cart button. This is because I initially built the main swiping view without any worry for a navigation bar/ button. This caused a lot of problems towards the end when I wanted to connect the Cart button to a new display since it had to be connected to an initial return statement.

What I learnt from this is to be more thoughtful about the UI at the beginning even before I code so that it is easier to structure my code around a nav bar (or other such elements).

### Mistakes
What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

A major mistake I made at the start of this assignment was underestimating how challenging even simple animations can be when building apps. My inital design had a sliding window to open the app, and rotation of cards just like tinder's cards.

I even referred to a few youtube videos on flutter animations but I ended up not using that since it was getting overly complicated.

### Optional Challenges
Tell us about what you did, learned, and struggled with while tackling some of the optional challenges.

I struggled a lot to make the linter pass. Whenever I run flutter analyze, it shows that there are no issues in my code. Despite that for some reason the linter seems to fail.

Update: This Ed thread: https://edstem.org/us/courses/66892/discussion/5624068
withOpacity is causing the failure.
I will try to fix it in the deadline but I am flagging it in the readme in case the autograder does not run in time.