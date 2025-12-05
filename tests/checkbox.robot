*** Settings ***
Resource    ../resources/base.resource

Test Teardown    Close Session

*** Test Cases ***
Should Mark Technologies That Use Appium
    [Tags]    checkbox
    
    # 1. Start the session
    Start Session
    Get Started
    
    # 2. Navigate to the Checkbox screen
    Navigate to    Check e Radio
    Wait Until Page Contains    Checkbox
    Click Text    Checkbox
    
    # 3. Verify if on the correct screen
    Wait Until Page Contains    Marque as techs que usam Appium
    
    # 4. Define data set (List of technologies to check)
    @{techs}=    Create List    Ruby    Python    Java    Javascript    C#    Robot Framework
    
    # 5. Iterate over the list clicking each option
    FOR    ${tech}    IN    @{techs}
        # Uses Click Element with Dynamic XPath + Contains
        Click Element    xpath=//android.widget.CheckBox[contains(@text, '${tech}')]
        Sleep    0.5
    END
    
    # 6. Final validation: Verify that technologies were checked
    Sleep    1
