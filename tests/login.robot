*** Settings ***
Resource        ../resources/base.resource

Test Setup      Start Session
Test Teardown   Close Session

*** Test Cases ***
Should Successfully Login
    [Tags]    login_success
    
    # Navigation
    Get Started
    Navigate to    Formulários
    Wait Until Page Contains    Login
    Click Text    Login
    Wait Until Page Contains    Olá Padawan, vamos testar o login?

    # Interaction - Fill in the form
    Input Text      id=com.qaxperience.yodapp:id/etEmail       yoda@qax.com
    Input Text      id=com.qaxperience.yodapp:id/etPassword    jedi
    
    # Submission
    Click Element   id=com.qaxperience.yodapp:id/btnSubmit

    # Validation (Happy Path)
    Wait Until Page Contains    Boas vindas, logado você está.

Should Not Login With Incorrect Password
    [Tags]    login_error
    
    # Navigation
    Get Started
    Navigate to    Formulários
    Wait Until Page Contains    Login
    Click Text    Login
    Wait Until Page Contains    Olá Padawan, vamos testar o login?

    # Interaction - Wrong Password
    Input Text      id=com.qaxperience.yodapp:id/etEmail       yoda@qax.com
    Input Text      id=com.qaxperience.yodapp:id/etPassword    sith
    
    # Submission
    Click Element   id=com.qaxperience.yodapp:id/btnSubmit

    # Validation (Sad Path)
    Wait Until Page Contains    Oops! Credenciais incorretas.
