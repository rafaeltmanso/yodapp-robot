*** Settings ***
Resource    ../resources/base.resource
Test Teardown    Close Session

*** Test Cases ***
Should Successfully Open Home Screen
    Start Session
    Validate Home Screen
