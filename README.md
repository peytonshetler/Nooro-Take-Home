#  Nooro Take Home


## Steps to Run
* Just run the project, nothing fancy here :)

* I appreciate your time!


## My Plan
What I was going for was this:
* When a user opens the app and, if a city name (String) is present in User Defaults, then display a CityView. If no city name is present in UserDefaults, then I would display an "Empty State View".

* Upon typing in the custom search bar at the top, the city view would would be replaced with a "ResultsView" (I would've used debouncing on the custom search bar to run the `viewModel.fetchWeather()` function when the user starts typing)

* When a user taps on a displayed result, UserDefaults would be updated with the city name associated with those results. Also, I would dismiss the results view and show the user the newly updated.

* All errors are handled by displaying an AlertView.


## Things I would change
* For starters, the first things I would change would be to finish it and make it perfect, haha. Five hours seems like a long time until you actually start!  But I really do appreciate the time limit, it's a good idea. 

Things I would change include:

1. I would finish the UI.
2. Handle ViewModel loading states
3. Complete the Userdefaults functionality.
