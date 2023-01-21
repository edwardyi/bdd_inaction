Feature: Shout

  Shouty allows users to "hear" other users "shouts" as long as they are close enough to each other.

  To do:
    - only shout to people within a certain distance
    - remove details "free bagels at Sean's",  amd "Free coffee"

  Background:
    - Given a person named Lucy 
    - And a person named Sean

  Rule: Shouts should only be heard if Listener is within range

  Scenario: Listener within range
    When Sean shouts
    Then Lucy hears Sean’s message

  Scenario: Listener hears a different message
    Given Lucy is 15m from Sean
    When Sean shouts 
    Then Lucy hears Sean’s message

  Scenario: Listener is within range
    Given the range is 100
    And people are located at
        | name | location |
        | Sean | 0        |
        | Lucy | 50       |
    When Sean shouts
    Then Lucy hears Sean’s message


  Scenario: Listener is out of range