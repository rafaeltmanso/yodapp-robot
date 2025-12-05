*** Settings ***
Resource    ../resources/base.resource
Test Teardown    Close Session

*** Test Cases ***
Should Interact With Buttons
    Start Session
    Get Started
    Navigate to    Clique em Botões
    Wait Until Page Contains    Long Click    
    Click Text                  Simple Click

Should Execute Long Click
    [Tags]      long

    Start Session
    Get Started
    Navigate to    Clique em Botões
    Go to item    Long Click    Long Click Button

    ${locator}    Set Variable    id=com.qaxperience.yodapp:id/long_click
    Long Press   ${locator}    duration=1000
    Wait Until Page Contains     This is a long click
