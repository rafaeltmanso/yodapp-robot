# yodapp-robot

Comprehensive end-to-end mobile testing automation for the **Yodapp** Android application using Robot Framework and Appium.

**Yodapp** is an educational mobile testing project developed by [**Fernando Papito**](https://github.com/papitodev), designed to teach and demonstrate best practices in mobile test automation.

## Tech Stack

![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.3-blue?style=flat-square&logo=robot%20framework)
![Appium](https://img.shields.io/badge/Appium-3.1.1-purple?style=flat-square&logo=appium)
![UIAutomator2](https://img.shields.io/badge/UIAutomator2-6.3.0-green?style=flat-square)
![Android](https://img.shields.io/badge/Android-Emulator-brightgreen?style=flat-square&logo=android)
![Node.js](https://img.shields.io/badge/Node.js-AppiumServer-green?style=flat-square&logo=node.js)
![Python](https://img.shields.io/badge/Python-3.13-blue?style=flat-square&logo=python)

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Installation & Setup](#installation--setup)
- [Running Tests](#running-tests)
- [Test Suite](#test-suite)
- [Key Architecture](#key-architecture)
- [Configuration](#configuration)
- [Test Results](#test-results)
- [Development Workflow](#development-workflow)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

**yodapp-robot** is a keyword-driven test automation framework for mobile testing using:

- **Framework**: Robot Framework (BDD-style automation)
- **Mobile Driver**: Appium with UIAutomator2 for Android automation
- **Test Application**: Yodapp Android Beta (educational app)
- **Target Environment**: Android Emulator (emulator-5554)
- **Test Language**: Robot Framework (`.robot` files)

This project demonstrates professional mobile testing practices including:
- Session management
- Element interaction and validation
- Test isolation and cleanup
- Comprehensive test reporting
- Appium capability configuration

---

## 📦 Prerequisites

Before running tests, ensure you have:

### Required Software
- **Python 3.13+** - For Robot Framework execution
- **Node.js & npm** - For Appium server
- **Android SDK** - For emulator and UIAutomator2
- **Android Emulator** - Running with `udid=emulator-5554`
- **Appium Server** - Running on `localhost:4723`

### Required Packages
All dependencies are listed in `package.json` and `robot.ini`:

```bash
npm install
```

This installs:
- **Appium 3.1.1** - Mobile automation server
- **appium-uiautomator2-driver 6.3.0** - Android automation driver

### Test Application
- **yodapp-beta.apk** must be placed at `app/yodapp-beta.apk` in the project root
- Application package: `com.qaxperience.yodapp`

---

## 📁 Project Structure

```
yodapp-robot/
├── README.md                 # Project documentation
├── package.json              # Node.js dependencies (Appium)
├── robot.ini                 # Robot Framework configuration
├── run_tests.sh              # Shell script for running tests
│
├── app/                      # Mobile application files
│   └── yodapp-beta.apk       # Android beta application
│
├── tests/                    # Test files (Robot Framework)
│   ├── home.robot            # Home screen tests
│   ├── login.robot           # Login flow tests
│   ├── login_debug.robot     # Debug login tests
│   ├── click.robot           # Click interaction tests
│   ├── checkbox.robot        # Checkbox component tests
│   ├── spinner.robot         # Spinner/dropdown tests
│   └── swipe.robot           # Swipe gesture tests
│
├── resources/                # Shared test resources
│   └── base.resource         # Base keywords and Appium setup
│
├── results/                  # Generated test results
│   ├── report.html           # Human-readable test report
│   ├── log.html              # Detailed execution log
│   └── output.xml            # Machine-readable test results
│
└── logs/                     # Alternative test output directory
    ├── report.html
    ├── log.html
    └── output.xml
```

---

## ⚙️ Installation & Setup

### Step 1: Clone & Install Dependencies

```bash
git clone <repository-url>
cd yodapp-robot
npm install
```

### Step 2: Start Android Emulator

```bash
# Start emulator with specific UDID
emulator -avd <your-avd-name> -no-snapshot -udid emulator-5554 &
```

### Step 3: Start Appium Server

```bash
# Using npm-installed Appium
npm start

# OR using system-wide Appium
appium --port 4723
```

Appium should be running at `http://localhost:4723` before running tests.

### Step 4: Place Test Application

Ensure `yodapp-beta.apk` is located at:
```
app/yodapp-beta.apk
```

The framework references it via `${EXECDIR}/app/yodapp-beta.apk` for portability across environments.

---

## 🚀 Running Tests

### Run All Tests

```bash
# Using shell script
./run_tests.sh

# Using npm script
npm test

# Using Robot Framework CLI directly
robot tests/
```

### Run Specific Test File

```bash
robot tests/home.robot
robot tests/login.robot
robot tests/swipe.robot
```

### Run Specific Test Case

```bash
robot -t "Should Successfully Open Home Screen" tests/home.robot
```

### Run with Custom Output Directory

```bash
robot --outputdir results tests/
```

### Run in Debug Mode (via RobotCode)

The project is configured for debugging with RobotCode extension in VS Code:

```bash
robotcode debug tests/home.robot
```

---

## 📊 Test Suite

### Test Files Overview

| Test File | Purpose | Test Cases |
|-----------|---------|-----------|
| `home.robot` | Home screen validation | Open home, navigate screens |
| `login.robot` | Login flow tests | Login success, invalid credentials |
| `login_debug.robot` | Debug login scenarios | Detailed login debugging |
| `click.robot` | Click interactions | Various click scenarios |
| `checkbox.robot` | Checkbox components | Check/uncheck operations |
| `spinner.robot` | Dropdown/spinner selection | Item selection |
| `swipe.robot` | Swipe gestures | Swipe interactions, Darth Vader removal |

### Example Test Case Structure

```robotframework
*** Settings ***
Resource    ../resources/base.resource
Test Teardown    Close Session

*** Test Cases ***
Should Successfully Open Home Screen
    Start Session
    Validate Home Screen
    Close Application
```

---

## 🏗️ Key Architecture

### AppiumLibrary Integration

The project uses **AppiumLibrary** for Robot Framework, providing keywords for:
- `Open Application` - Start Appium session
- `Wait Until Page Contains` - Element visibility assertions
- `Click Text` / `Click Element` - Element interactions
- `Close Application` - Session cleanup

### Shared Keywords (base.resource)

All tests inherit base keywords from `resources/base.resource`:

```robotframework
Start Session
    # Opens Appium session with Android configuration
    Open Application    http://localhost:4723
    ...    platformName=Android
    ...    deviceName=Android Emulator
    ...    automationName=UIAutomator2
    ...    app=${EXECDIR}/app/yodapp-beta.apk
    ...    udid=emulator-5554
    ...    autoGrantPermissions=true
```

### Session Isolation

- Each test opens and closes its own Appium session
- `Test Teardown` keyword automatically closes sessions after each test
- No shared state between test cases (isolated execution)

---

## ⚙️ Configuration

### Appium Capabilities

| Capability | Value | Purpose |
|-----------|-------|---------|
| `platformName` | Android | Target platform |
| `deviceName` | Android Emulator | Device description |
| `automationName` | UIAutomator2 | Android automation framework |
| `app` | `${EXECDIR}/app/yodapp-beta.apk` | Application path |
| `udid` | `emulator-5554` | Emulator device identifier |
| `autoGrantPermissions` | true | Auto-grant app permissions |
| `appWaitPackage` | `com.qaxperience.yodapp` | App package name |
| `appWaitActivity` | `*` | Wait for any activity |
| `forceAppLaunch` | true | Force app restart |

### Variables (base.resource)

```robotframework
${START}      QAX              # Start button text
${TIMEOUT}    30               # Default timeout (seconds)
```

---

## 📋 Test Results

Robot Framework generates comprehensive test reports in the `results/` directory:

### Report Files

1. **report.html** - Executive summary with test statistics and pass/fail overview
2. **log.html** - Detailed step-by-step execution log with keyword outputs
3. **output.xml** - Machine-readable results for CI/CD integration

### Accessing Reports

After running tests:

```bash
# Open report in browser (Windows)
start results/report.html

# Open detailed log
start results/log.html

# View report from command line
cat results/report.html
```

### Test Metrics

Reports include:
- Total test count (passed, failed, skipped)
- Execution time per test
- Keyword execution details
- Error messages and screenshots
- Test statistics and trends

---

## 💻 Development Workflow

### Adding New Test Cases

1. **Create test file** or add to existing `tests/*.robot`
2. **Import base resource**:
   ```robotframework
   *** Settings ***
   Resource    ../resources/base.resource
   Test Teardown    Close Session
   ```
3. **Write test cases** using AppiumLibrary keywords
4. **Run locally** to validate before committing

### Example: New Test Case

```robotframework
*** Test Cases ***
Should Successfully Login
    Start Session
    Navigate to    Login
    Enter Credentials    user@example.com    password123
    Wait Until Page Contains    Dashboard
    Close Application
```

### Debugging Test Failures

1. **Check log.html** for detailed keyword execution
2. **Verify Appium server** is running on localhost:4723
3. **Confirm emulator** is running with correct UDID
4. **Validate APK** path and permissions
5. **Use RobotCode debugger** for step-by-step execution

### Version Control

- `app/yodapp-beta.apk` is committed to repository
- `results/` and `logs/` directories are typically gitignored
- All source files (`.robot`, `.resource`) are tracked

---

## 🔧 Troubleshooting

### Appium Server Connection Failed

**Error**: `Connection refused on http://localhost:4723`

**Solution**:
```bash
# Ensure Appium is running
npm start

# Or manually start Appium
appium --port 4723
```

### Emulator Not Found

**Error**: `Could not find device emulator-5554`

**Solution**:
```bash
# List available emulators
emulator -list-avds

# Start emulator with correct UDID
emulator -avd <avd-name> -no-snapshot -udid emulator-5554 &
```

### APK Not Found

**Error**: `App file not found at ${EXECDIR}/app/yodapp-beta.apk`

**Solution**:
- Verify `app/yodapp-beta.apk` exists in project root
- Check file path is correct: `c:\QAx\projects\yodapp-robot\app\yodapp-beta.apk`
- Ensure APK is not corrupted

### Permission Denied on Tests

**Error**: `Permission denied or app not responding`

**Solution**:
- Verify `autoGrantPermissions=true` in Appium capabilities
- Clear emulator app data before testing
- Ensure app package matches: `com.qaxperience.yodapp`

### Timeout on Elements

**Error**: `Waiting for element ... FAILED`

**Solution**:
- Increase `${TIMEOUT}` value in `base.resource`
- Verify element selector/text is correct
- Check app is fully loaded before assertions

### Robot Framework Not Found

**Error**: `Command 'robot' not found`

**Solution**:
```bash
# Ensure Robot Framework is installed
pip install robotframework

# Or use with explicit Python
python -m robot tests/
```

---

## 📚 Additional Resources

- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [AppiumLibrary Documentation](https://github.com/appium/AppiumLibrary-py)
- [Appium Official Documentation](http://appium.io/docs/en/drivers/android-uiautomator2/)
- [Android Emulator Documentation](https://developer.android.com/studio/run/emulator)

---

## 🤝 About Yodapp

**Yodapp** is an educational Android application developed by [**Fernando Papito**](https://github.com/papitodev) to teach and demonstrate mobile testing automation concepts. It's used for learning:

- Mobile app testing with Appium
- Test automation frameworks
- BDD-style test writing
- Mobile gesture interaction testing
- Cross-platform automation strategies

---

## 📝 License

ISC License - See package.json for details

---

**Project Author**: Rafael Manso  
**App Developer**: Fernando Papito  
**Last Updated**: December 2025
