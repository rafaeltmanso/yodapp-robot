*** Settings ***
Resource        ../resources/base.resource

Test Setup      Start Session
Test Teardown   Close Session

*** Test Cases ***
Debug - Check Error Message
    [Tags]    debug
    
    Get Started
    Navigate to    Formulários
    Wait Until Page Contains    Login
    Click Text    Login
    Wait Until Page Contains    Olá Padawan, vamos testar o login?

    Input Text      id=com.qaxperience.yodapp:id/etEmail       yoda@qax.com
    Input Text      id=com.qaxperience.yodapp:id/etPassword    sith
    
    Click Element   id=com.qaxperience.yodapp:id/btnSubmit

    # Log the entire page
    Log Source
    Sleep    2
