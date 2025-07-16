Feature: Add New Topic

  Background: 
    Given the user is logged in to the Internal Audit Management System  
    And the user has the necessary permissions to add, edit, view, delete a new topic  
    And the user is on the Active tab 

  Scenario: Adding a new topic using the "Other" option from the Source dropdown  
    When the user selects the "Other" option from the Source dropdown  
    And the user selects an appropriate option from the Domain dropdown
    And the user selects a Process Owner from the Process Owner dropdown
    And the user enters the following details:
      | Field             | Value                      |
      | Topic Title       | <Topic Title>              |
      | Audit Frequency   | <Audit Frequency in Days>  |
      | Topic Description | <Topic Description>        |
    And the user clicks on the "Send for Approval" button   
    Then the user should see a success message: "Request Sent Successfully"  
    And the user should be redirected to the "Audit Topic List" page  
    And the new topic should be listed with the status "Under Review"  
    And the "Created Date" should reflect the current date

  Scenario: Adding a new topic using the "DCS Document" option from the Source dropdown
    When the user selects the "DCS Document" option from the Source dropdown
    And the user selects a valid published document from the list
    Then the Process Owner dropdown should be autofilled based on the selected DCS document
    And the user enters the following details:
      | Field             | Value                      |
      | Topic Title       | <Topic Title>              |
      | Audit Frequency   | <Audit Frequency in Days>  |
      | Topic Description | <Topic Description>        |
    And the user clicks on the "Send for Approval" button   
    Then the user should see a success message: "Request Sent Successfully"  
    And the user should be redirected to the "Audit Topic List" page  
    And the new topic should be listed with the status "Under Review"  
    And the "Created Date" should reflect the current date

  Scenario: Frequency Days field Validation
    When the user clicks on the Frequency field
    And  press up and down arrow keys
    Then the according number of days should be added or subtracted from the field
    And the user should not be able to enter a negative number in the Frequency field
    And the user should not be able to enter a non-numeric value in the Frequency field

  Scenario: Clicking cancel button while adding a new topic
    When the user clicks the "Cancel" button while adding a new topic
    Then the user should be redirected to the "Audit Topic List" page  
    And no changes should be saved to the new topic form

  Scenario: Dropdown visibility when the user selects "Other"
    When the user selects the "Other" option from the Source dropdown  
    And the user selects an appropriate option from the Domain dropdown  
    Then only the Process Owner dropdown should be visible with the list of Process Owners appropriate to the selected Domain
    And the user should be able to search in the dropdown from the available options

  Scenario: Dropdown visibility when the user selects "DCS Document"
    When the user selects the "DCS Document" option from the Source dropdown  
    Then an additional dropdown to select a published DCS document should be visible
    And the user should be able to select and search a DCS Document from the dropdown options
    And the Process Owner dropdown should be autofilled based on the selected DCS document
    And the Process Owner dropdown should not be editable

  Scenario: Selecting multiple DCS Documents
    When the user clicks the plus icon beside the additional DCS Document dropdown
    Then the user should be able to select multiple documents from the list, one each time the plus icon is clicked
    And the user should be able to search in each dropdown from the available options
    And the Process Owner dropdown should be autofilled based on the selected DCS document
    And the Process Owner dropdown should not be editable

  Scenario: Removing a DCS Document after adding multiple documents
    When the user clicks the minus icon beside a specific DCS Document dropdown
    Then the selected DCS document should be removed from the list of added documents

  Scenario: Send for Approval button behavior and visibility
    When the user leaves any one of the required fields empty
    Then the "Send for Approval" button should be disabled and not clickable
    And the user should be able to click the "Cancel" button to discard changes
    And the "Cancel" button should be visible and clickable even if fields are empty


  #View/Edit/Delete Audit Topic

  Scenario: Display all fields in read mode
    Given the user is on the "View Topic" screen
    When the user views the topic details
    Then all topic fields should be displayed in a read-only state
    And the topic title, source, domain, process owner, audit frequency, and description should be visible

  Scenario: Display topic status and dates
    When the user opens the topic in view mode from the Audit Topic List
    Then the topic status should be displayed clearly
    And the due date should be shown beside the status
    And the next audit plan date should be visible
    And the last audit date should be displayed

  Scenario: Edit topic button visibility and behavior
    Given the user has permission to edit topic once Created
    When the user opens the topic in view mode from the Audit Topic List
    Then the Edit Topic button should be visible and enabled
    
  Scenario: Edit topic button is not visible for the user without permission
    Given the user does not have permission to edit topics
    When the user opens the topic in view mode
    Then the Edit Topic button should not be visible to the user

  Scenario: Enable fields after clicking Edit Topic
    Given the user has the permission to edit topics
    When the user clicks the Edit Topic button
    Then the screen should switch to edit mode
    And the fields should be editable
    And the user should be able to modify the details
    And Save and Cancel buttons also should be visible and clickable
    And Delete button should be visible and clickable

  Scenario:Yes button behavior while deleting a document in edit topic screen
    When the user clicks the delete button in the edit topic screen
    Then a confirmation and reason for deletion popup should be displayed
    And until the user enters a reason for deletion, the yes button should be disabled
    And after entering the reason, the yes button should be enabled
    And Clicking the yes button should delete the topic from the list
    And the user should be redirected to the Audit Topic List page

  Scenario: No button behavior while deleting a document in edit topic screen
    When the user clicks the delete button in the edit topic screen
    Then a confirmation and reason for deletion popup should be displayed
    And the user clicks the No button
    And the user should be redirected to the Audit edit topic screen again
    And the topic should not be deleted

  Scenario: Cancel button behavior
    Given the user is viewing a topic
    When the user clicks the Cancel button
    Then the user should be redirected to the Audit Topic List page

  Scenario: Error message behavior
    When the user performs an invalid action or leaves a required field empty
    Then an appropriate error message should be displayed to the user


    
