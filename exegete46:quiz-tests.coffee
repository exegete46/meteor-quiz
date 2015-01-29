# Write your tests here!
# Here is an example.
Tinytest.add 'example', (test) ->
  test.equal(true, true);

quizCollection = new Meteor.Collection 'test_quiz'
quizzer = new Quiz quizCollection

if Meteor.isServer
  Meteor.methods {
    'createQuiz': (description, options) ->
      quizzer.create description, options
    'upvoteQuiz': (quizId, option, ident) ->
      quizzer.vote quizId, option, ident
  }
  Meteor.publish 'quizCollection', ->
    quizCollection.find {}

if Meteor.isClient
  Meteor.subscribe 'quizCollection'

quiz_options = ['first', 'second', 'third', 'fourth']
quiz_description = "Test Description"
createQuiz = (callback) ->
  Meteor.call 'createQuiz', quiz_description, quiz_options, (err, val) ->
    if err
      throw new Meteor.Error err
    callback(val)
upvoteQuiz = (quizId, opt, ident, callback) ->
  Meteor.call 'upvoteQuiz', quizId, opt, ident, (err, val) ->
    if err
      throw new Meteor.Error err
    callback(val)


describe 'exegete46:quiz', ->
  context '#create', ->
  context '#vote', ->

## Server only testing.
if Meteor.isServer
  describe 'exegete46:quiz', ->
    context '#create', ->
      it "options - won't allow no options", (test) ->
        test.throws ->
          quizzer.create quiz_description, []
      it 'options - adds all of the options', (test) ->
        quizId = quizzer.create quiz_description, quiz_options
        quiz = quizCollection.findOne(quizId)
        test.equal quiz.options.length, quiz_options.length
      it "description - won't allow blank description", (test) ->
        test.throws ->
          quizzer.create "", quiz_options
      it "description - stores the description", (test) ->
        quizId = quizzer.create quiz_description, quiz_options
        quiz = quizCollection.findOne(quizId)
        test.equal quiz.description, quiz_description
      it 'persists to Mongo', (test) ->
        quizCollection.remove {}
        test.equal(quizCollection.find({}).count(), 0)
        createQuiz (quizId) ->
          test.equal(quizCollection.find({}).count(), 1)
    context '#vote', ->
      it 'increments total votes', (test) ->
        quizId = quizzer.create quiz_description, quiz_options
        up = quizzer.vote quizId, quiz_options[1], "user1"
        test.equal up, 1
        up2 = quizzer.vote quizId, quiz_options[0], "user2"
        test.equal up2, 1
        quiz = quizCollection.findOne(quizId)
        test.equal quiz.total_responses, 2
      it "shouldn't allow votes from the same user twice", (test) ->
        quizId = quizzer.create quiz_description, quiz_options
        up = quizzer.vote quizId, quiz_options[1], "user1"
        test.equal up, 1
        test.throws ->
          quizzer.vote quizId, quiz_options[0], "user1"
        quiz = quizCollection.findOne(quizId)
        test.equal quiz.total_responses, 1
      it "should require a valid option", (test) ->
        quizId = quizzer.create quiz_description, quiz_options
        test.throws ->
          quizzer.vote quizId, "Non-existant option!", "user1"
