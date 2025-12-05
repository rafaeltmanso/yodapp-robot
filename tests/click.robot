*** Settings ***
Resource    ../resources/base.resource
Test Teardown    Close Session

*** Test Cases ***
Deve interagir com botoes
    Start Session
    Get Started
    Navigate to    Clique em Botões
    Wait Until Page Contains    Clique longo    
    Click Text                  Clique simples

Deve executar clique longo
    [Tags]      long

    Start Session
    Get Started
    Navigate to    Clique em Botões
    Go to item    Clique longo    Botão clique longo

    ${locator}    Set Variable    id=com.qaxperience.yodapp:id/long_click
    Long Press   ${locator}    duration=1000
    Wait Until Page Contains     Isso é um clique longo
