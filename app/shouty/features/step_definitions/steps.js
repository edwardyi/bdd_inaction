const { Given, When, Then, Before } = require('cucumber')
const { assertThat, is } = require('hamjest')

const { Person, Network } = require('../../src/shouty')

// defineParameterType({
//   name: 'people',
//   regexp: /Lucy|Sean/,
//   transformer: name => new Person(name)
// })

const default_range = 100

Before(function () {
  this.people = {}
  this.network = new Network(default_range)

  // add sean to people array
  this.people['sean'] = new Person(this.network)
})

Given('the range is {int}', function (range) {
  this.network = new Network(range)
})

Given('a person named {word}', function (name) {
  this.people[name] = new Person(this.network)
})

Given('a person name {word} is located at {int}', function (name, location) {
  this.people[name] = new Person(this.network, location)
})

Given('people are located at', function (dataTable) {
  // console.log(dataTable.raw(2, 1))
  dataTable.hashes().map((person) => {
    this.people[person.name] = new Person(this.network, person.location)
  })
})
// Given('a person named Sean', function () {
//   this.sean = new Person(this.network)
// })

// Given('Lucy is {int} metres from Sean', function (distance) {
//   this.network = new Network()
//   this.people['lucy'] = new Person(this.network)
//   this.people['sean'] = new Person(this.network)

//   this.people['lucy'].moveTo(distance)
// })

When('Sean shouts', function () {
  // console.log(this.people, 'testing')
  this.people['sean'].shout("Hello world")
})

When('Sean shouts {string}', function (message) {
  this.people['sean'].shout(message)
  this.messageFromSean = message
})

Then('Lucy should hear a shout', function () {
  assertThat(this.people['lucy'].messagesHeard.length, is(1))
})

Then('Lucy should hear Sean\'s message', function () {
  assertThat(this.people['lucy'].messagesHeard(), contains([this.messageFromSean]))
})

Then('Larry should not hear a message', function () {
  assertThat(this.people['Larry'].messagesHeard(), not(contains([this.messageFromSean])))
})