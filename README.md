# Quiz

## Collections

- Quiz
  - Array - Options
  - Count - Votes
  - Array - Voters
    - Which `userId`s have responded?

## Methods

- create("description", [options])
- vote("quizId", "userId", "choice")
  - If the user has already chosen, throw an error.
  - Must validate "choice".
  - Must validate Quiz is enabled.
- disable("quizId")
