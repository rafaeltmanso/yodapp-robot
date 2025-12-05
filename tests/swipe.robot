*** Settings ***
Documentation    Test suite for validating the Swipe gesture
Resource         ../resources/base.resource

Test Setup       Start Session
Test Teardown    Close Session

*** Variables ***
${SWIPE_OFFSET}    650

*** Test Cases ***
Should Remove Darth Vader
    [Tags]    swipe
    Get Started
    Navigate to       Star Wars
    Go to item        List    Darth Vader

    # 1. Locator strategy: Find the text, go up to parent container, then find the indicator ID
    ${element_xpath}=    Set Variable    xpath=//android.widget.TextView[@text='@darthvader']/../../..//*[contains(@resource-id, 'indicator')]

    # 2. Get the Element Location (returns a dictionary with x and y coordinates)
    ${element_location}=    Get Element Location    ${element_xpath}

    # 3. Extract X and Y coordinates from the location dictionary
    ${start_x}=    Set Variable    ${element_location['x']}
    ${start_y}=    Set Variable    ${element_location['y']}

    # 4. Calculate the destination X (Swipe Left means subtracting from X)
    # CRITICAL: Use 'Evaluate' for math operations, not 'Set Variable'
    ${offset_x}=    Evaluate    ${start_x} - ${SWIPE_OFFSET}
    ${offset_y}=    Set Variable    ${start_y}

    # 5. Perform the Swipe gesture
    # Arguments: start_x, start_y, end_x, end_y, duration
    Swipe    start_x=${start_x}    start_y=${start_y}    end_x=${offset_x}    end_y=${offset_y}    duration=1000ms

    # 6. Click the Remove/Trash button that appears after swipe
    Click Element    id=com.qaxperience.yodapp:id/btnRemove

    # 7. Verify the item was deleted
    Wait Until Page Does Not Contain    Darth Vader
