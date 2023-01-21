
const Person = require("../../src/shouty.js")

const { defineParameterType } = require("cucumber")

defineParameterType({
    name: 'person',
    regexp: /Lucy|Sean/,
    transformer: name => new Person(name)
})