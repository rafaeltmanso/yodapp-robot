*** Settings ***
Resource    ../resources/base.resource

Test Teardown    Close Session

*** Test Cases ***
Deve marcar as techs que usam Appium
    [Tags]    checkbox
    
    # 1. Inicia a sessão
    Start Session
    Get Started
    
    # 2. Navega até a tela de Checkbox
    Navigate to    Check e Radio
    Wait Until Page Contains    Checkbox
    Click Text    Checkbox
    
    # 3. Verifica se está na tela correta
    Wait Until Page Contains    Marque as techs que usam Appium
    
    # 4. Define a massa de dados (Lista de techs a marcar)
    @{techs}=    Create List    Ruby    Python    Java    Javascript    C#    Robot Framework
    
    # 5. Itera sobre a lista clicando em cada opção
    FOR    ${tech}    IN    @{techs}
        # Usa Click Element com XPath Dinâmico + Contains
        Click Element    xpath=//android.widget.CheckBox[contains(@text, '${tech}')]
        Sleep    0.5
    END
    
    # 6. Validação final: Verifica se as techs foram marcadas
    Sleep    1
