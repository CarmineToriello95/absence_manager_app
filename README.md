# 🚀 Crewmeister coding challenge - Frontend (Flutter)

The checkmarked requirements have been satisfied:

- [x] I want to see a list of absences including the names of the employees.
- [x] I want to see the first 10 absences, with the ability to paginate.
- [x] I want to see a total number of absences.
- [x] For each absence I want to see:
  - [x] Member name
  - [x] Type of absence
  - [x] Period
  - [x] Member note (when available)
  - [x] Status (can be 'Requested', 'Confirmed' or 'Rejected')
  - [x] Admitter note (when available)
- [x] I want to filter absences by type.
- [x] I want to filter absences by date.
- [x] I want to see a loading state until the list is available.
- [x] I want to see an error state if the list is unavailable.
- [x] I want to see an empty state if there are no results.
- [ ] (Bonus) I can generate an iCal file and import it into outlook.

## App Preview

https://github.com/user-attachments/assets/d7a08718-fa21-4ade-a4d5-3ab95d0469ca

## Implementation approach

The project has been implemented following the [clean code architecture described by uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

Main packages used:
*dependency injection* (get_it, injectable), *state management* (flutter_bloc), *functional programming* (dartz).

The lib folder structure is the following:

- lib/
    - core/ : contains tools(errors, utils, widgets) used globally in the project
    - features/ :  contains the main features of the app (absence manager)
    - di_config.dart : contains the configuration for the dependency injection
    - main.dart

The test folder structure is similar to the lib folder structure:

- test/
    - core/
    - features/
