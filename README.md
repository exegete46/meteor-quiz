# Quiz

## Collections

- Users (duh?)
- Quizes
  - Array - Options
    - Count - Choices
  - Array - Responses
    - Which `userId`s have responded?

## Methods

- quizCreate([options])
- quizResponse('quizId', 'userId', 'choice')
  - If the user has already chosen, change to new choice.
- quizDisable('quizId')
