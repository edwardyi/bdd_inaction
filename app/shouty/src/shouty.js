class Person {
  constructor(network) {
    this.messages = []
    this.network = network

    this.messages.push(network) 

    this.network.subscribe(this)
  }
  moveTo(distance) {

  }

  shout(message) {
    this.messages.forEach(function (rowMessage) {
      rowMessage.broadcasts(message)
    });
    
  }

  hear(message) {
    this.messages.push(message)
  }

  messagesHeard() {
    return this.messages
    // return ["free bagels at Sean's"]
  }
}

class Network {
  constructor(range) {
    this.listeners = [];
    this.range = range;
  }

  subscribe(person) {
    this.listeners.push(person)
  }

  broadcasts(message, shouter_location) {
    this.listeners.forEach(listener => {
      if (Math.abs(listener.location - shouter_location) <= this.range) 
        listener.hear(message)
    })
  }
}

module.exports = {
  Person : Person,
  Network: Network
}
