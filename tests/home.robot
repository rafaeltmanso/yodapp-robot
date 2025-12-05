*** Settings ***
Resource    ../resources/base.resource
Test Teardown    Close Session

*** Test Cases ***
Deve abrir tela inicial com sucesso
    Start Session
    Validate Home Screen
