*** Settings ***
Documentation    Test suite for validating the Spinner component
Resource         ../resources/base.resource

Test Setup       Start Session
Test Teardown    Close Session

*** Test Cases ***
Should Select Padawan Level
    Go To Registration Form
    Select Level    Padawan

Should Select Jedi Level
    Go To Registration Form
    Select Level    Jedi

Should Select Sith Level
    Go To Registration Form
    Select Level    Sith

Should Select Other Level
    Go To Registration Form
    Select Level    Outros

*** Keywords ***
Go To Registration Form
    Get Started
    Navigate to       Formulários
    Go to item        Cadastro    Crie sua conta

Select Level
    [Arguments]    ${level}
    # 1. Click the Spinner to expand
    Click Element                   id=com.qaxperience.yodapp:id/spinnerJob
    
    # 2. Wait for the ListView to appear
    Wait Until Element Is Visible   class=android.widget.ListView
    
    # 3. Click the specific option by text
    Click Text                      ${level}
