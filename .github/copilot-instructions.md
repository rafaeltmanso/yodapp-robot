# Copilot Instructions for yodapp-robot

This is a **Robot Framework mobile testing project** for Yodapp Android app using Appium and UIAutomator2.

## Project Overview

- **Purpose**: End-to-end mobile testing for the Yodapp application
- **Framework**: Robot Framework (BDD-style test automation)
- **Mobile Testing**: Appium with UIAutomator2 driver for Android
- **Test App**: `app/yodapp-beta.apk` (Android beta app)
- **Target Device**: Android Emulator (emulator-5554)
- **Language**: Robot Framework (keyword-driven)

## Key Architecture

### Test Structure
- `tests/home.robot` - Main test file containing test cases
- Uses **AppiumLibrary** keyword library for mobile interactions
- Tests require running Appium server on `localhost:4723`
- Results generated in `results/` (HTML report, log, XML output)

### Appium Configuration
Standard Robot Framework + Appium setup:
```robot
Open Application    http://localhost:4723
...    platformName=Android
...    deviceName=Android Emulator
...    automationName=UIAutomator2
...    app=${EXECDIR}/app/yodapp-beta.apk
...    udid=emulator-5554
...    autoGrantPermissions=true
```

Critical parameters:
- **UIAutomator2**: Standard Android automation tool
- **autoGrantPermissions**: Auto-grants permissions (critical for emulator testing)
- **udid**: Device identifier for emulator

## Essential Developer Workflows

### Running Tests
Tests are NOT configured in npm scripts. Use Robot Framework CLI directly:
```bash
robot tests/home.robot
```

**Prerequisites**: 
- Appium server running (`npm start` if installed, or system appium)
- Android emulator running with udid=emulator-5554
- APK placed at `app/yodapp-beta.apk`

### Test Results
Robot Framework generates three output files in `results/`:
- `report.html` - High-level test summary (human-readable)
- `log.html` - Detailed step-by-step execution log
- `output.xml` - Machine-readable results for CI/CD

## Project Patterns & Conventions

### Test Case Structure
- One test per "*** Test Cases ***" section
- Uses **keyword-driven approach** (AppiumLibrary keywords)
- Clean assertions: `Wait Until Page Contains [text]`
- Always close with `Close Application`

### Mobile Element Interaction
AppiumLibrary provides keywords for:
- `Open Application` - Start session
- `Wait Until Page Contains` - Visibility assertions
- `Close Application` - Cleanup

## Important Notes

### No Abstract Keywords Layer
This project uses AppiumLibrary keywords directly in tests without custom keyword wrappers. If expanding tests, maintain this direct approach for simplicity.

### Appium Lifecycle
- Each test opens/closes its own application session
- No shared setup between tests (isolated execution)
- Session cleanup is explicit with `Close Application`

### APK Management
The beta APK is committed to the repo at `app/yodapp-beta.apk`. Tests reference it via `${EXECDIR}` (test execution directory) for portability.

## Dependencies

- **Robot Framework 7.3.2** - Test execution engine
- **Appium 3.1.1** - Mobile test driver (Node.js)
- **UIAutomator2 Driver 6.3.0** - Android automation
- **AppiumLibrary** - Robot Framework bindings for Appium (installed via RobotCode LSP)

## Common Tasks

**Adding new test**: Create new "*** Test Cases ***" block in `home.robot` with AppiumLibrary keywords.

**Debugging failures**: Check `results/log.html` for detailed step execution and element lookup failures.

**Updating Appium config**: Modify the `Open Application` call parameters in test cases directly.
