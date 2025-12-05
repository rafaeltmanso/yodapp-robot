*** Settings ***
Library    AppiumLibrary
Library    Collections

*** Variables ***
${START}      QAX
${TIMEOUT}    30

*** Keywords ***
Start Session
    # Appium capability configuration (encapsulated)
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
    # Opens the navigation menu and clicks on the item
    ${hamburger}    Set Variable    //android.widget.ImageButton[@content-desc="Open navigation drawer"]
    Wait Until Element Is Visible    ${hamburger}    ${TIMEOUT}
    Click Element    ${hamburger}
    
    # Clicks on the dynamic menu item
    ${menu_item}    Set Variable    xpath=//*[@resource-id="com.qaxperience.yodapp:id/navView"]//*[@text="${item_text}"]
    Wait Until Element Is Visible    ${menu_item}    ${TIMEOUT}
    Click Element    ${menu_item}

Go to item
    [Arguments]    ${item}    ${checkpoint}
    # Clicks on the item and validates if it navigated to the correct screen
    Wait Until Page Contains    ${item}    ${TIMEOUT}
    Click Text                  ${item}
    Wait Until Page Contains    ${checkpoint}

Close Session
    Close Application

Validate Home Screen
    # Home screen validations
    Wait Until Page Contains    Yodapp    ${TIMEOUT}
    Wait Until Page Contains    Mobile Training
    Wait Until Page Contains    by Papito!

Perform Long Click
    # Performs long press using dynamic coordinates
    # First ensures it's on the "Long Click" screen
    Wait Until Page Contains    Long Click    ${TIMEOUT}
    
    # Defines the locator for the "Long Click" button
    ${long_click_locator}    Set Variable    xpath=//*[@text="Long Click"]
    
    # Gets the dynamic coordinates of the element
    ${position}    Get Element Location    ${long_click_locator}
    Log    Position: ${position}    WARN
    
    # Extracts x and y from the returned dictionary
    ${x}    Set Variable    ${position}[x]
    ${y}    Set Variable    ${position}[y]
    Log    X: ${x}, Y: ${y}    WARN
    
    # Performs the long tap with 1000ms duration using timedelta format
    Tap With Positions    1000ms    ${x}    ${y}
    
    # Validates that the long click worked
    Wait Until Page Contains    This is a long click    ${TIMEOUT}
