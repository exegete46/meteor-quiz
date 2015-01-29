# Write your package code here!

class Quiz
  constructor: (@quizCollection) ->
  create: (description, options) ->
    check description, String
    check options, Array
    if options.length is 0
      throw new Meteor.Error('Must specify options.')
    if description.length is 0
      throw new Meteor.Error('Description cannot be blank.')
    data = {
      description: description,
      options: options,
      voters: []
    }
    data.total_responses = 0;
    @quizCollection.insert(data)
  , vote: (quizId, option, ident) ->
    check quizId, String
    check option, String
    check ident, String
    quiz = @quizCollection.findOne(quizId)
    if _.include(quiz.voters, ident)
      throw new Meteor.Error("Can only vote once.")
    if !_.include(quiz.options, option)
      throw new Meteor.Error("Must be a valid option.")
    @quizCollection.update {
        _id: quizId,
        voters: {$ne: ident}
      }, {
        $inc: {
          total_responses: 1
        },
        $addToSet: {
          voters: ident
        }
    }

class QuizViews
  constructor: (@quizCollection) ->
  helpers: {
    foo: ->
      "bar"
  },
  events: {
    'click .bar': ->
      alert "baz"
  }

# quizView = new QuizViews quizCollection
# Template.quiz.helpers quizView.helpers
# Template.quiz.events quizView.events
