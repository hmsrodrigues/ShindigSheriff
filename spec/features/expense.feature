Feature: Expenses

 Scenario: Succesfully creating a new expense
    Given I am a logged in user with an event
      And I am at the event new expense page
    When I complete the form with the following:

      | ID                         | Input                     |
      | expense_estimated_amount   | 10.00                     |
      | expense_category_details   | meeting setup             |   

      And I click "Add Expense"
    Then I should see "$10.00"

  Scenario: Incomplete form
    Given I am a logged in user with an event
      And I am at the event new expense page
    When I complete the form with the following:

      | ID                         | Input                     |
      | expense_estimated_amount   | 10.00                     |
      | expense_category_details   | meeting setup             |   

      And I click "Add Expense"
    Then I should see "Estimated Amount can't be blank"
