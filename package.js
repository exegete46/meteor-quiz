Package.describe({
  name: 'exegete46:quiz',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Simple quiz interface using buttons.',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.3.1');
  api.use(['artwells:accounts-guest', 'coffeescript', 'livedata']);
  api.addFiles('exegete46:quiz.coffee');
  if (api.export)
    api.export('Quiz');
});

Package.onTest(function(api) {
  api.use([
    'tinytest',
    'test-helpers',
    'coffeescript',
    'peterellisjones:describe',
    'livedata'
  ]);
  api.use('exegete46:quiz');
  api.addFiles('exegete46:quiz-tests.coffee');
});
