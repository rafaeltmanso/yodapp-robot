*** Settings ***
Library    AppiumLibrary
Library    Collections

*** Variables ***
${START}      QAX
${TIMEOUT}    30

*** Keywords ***
Start Session
    # Configurações de capability do Appium (Encapsuladas)
    Open Application    http://localhost:4723
    ...                 platformName=Android
    ...                 deviceName=Android Emulator
    ...                 automationName=UIAutomator2
    ...                 app=${EXECDIR}/app/yodapp-beta.apk
    ...                 udid=emulator-5554
    ...                 autoGrantPermissions=true
    ...                 appWaitPackage=com.qaxperience.yodapp
    ...                 appWaitActivity=*
    ...                 forceAppLaunch=true

Get Started
    Log Source
    Wait Until Page Contains    Yodapp    ${TIMEOUT}
    Wait Until Page Contains    ${START}    ${TIMEOUT}
    Click Text                  ${START}

Navigate to
    [Arguments]    ${item_text}
    # Abre o menu de navegação e clica no item
    ${hamburger}    Set Variable    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
    Wait Until Element Is Visible    ${hamburger}    ${TIMEOUT}
    Click Element    ${hamburger}
    
    # Clica no item de menu dinâmico
    ${menu_item}    Set Variable    xpath=//*[@resource-id="com.qaxperience.yodapp:id/navView"]//*[@text="${item_text}"]
    Wait Until Element Is Visible    ${menu_item}    ${TIMEOUT}
    Click Element    ${menu_item}

Go to item
    [Arguments]    ${item}    ${checkpoint}
    # Clica no item e valida se chegou na tela certa
    Wait Until Page Contains    ${item}    ${TIMEOUT}
    Click Text                  ${item}
    Wait Until Page Contains    ${checkpoint}

Close Session
    Close Application

Validate Home Screen
    # Validações da tela inicial
    Wait Until Page Contains    Yodapp    ${TIMEOUT}
    Wait Until Page Contains    Mobile Training
    Wait Until Page Contains    by Papito!

Perform Long Click
    # Implementa long press usando coordenadas dinâmicas
    # Primeiro garante que está na tela "Clique longo"
    Wait Until Page Contains    Clique longo    ${TIMEOUT}
    
    # Define o locator para o botão "Clique longo"
    ${long_click_locator}    Set Variable    xpath=//*[@text="Clique longo"]
    
    # Obtém as coordenadas dinâmicas do elemento
    ${position}    Get Element Location    ${long_click_locator}
    Log    Position: ${position}    WARN
    
    # Extrai x e y do dicionário retornado - tenta acesso simples
    ${x}    Set Variable    ${position}[x]
    ${y}    Set Variable    ${position}[y]
    Log    X: ${x}, Y: ${y}    WARN
    
    # Executa o tap longo com duração de 1000ms usando timedelta format
    Tap With Positions    1000ms    ${x}    ${y}
    
    # Valida que o long click funcionou
    Wait Until Page Contains    Isso é um clique longo    ${TIMEOUT}
