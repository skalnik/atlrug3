Feature: Talks can be proposed and approved
  Scenario: User submits a proposal
    When I submit a talk named "Debugging with Pry" with length of 30 minutes
    Then I should see the talk was submitted successfully
