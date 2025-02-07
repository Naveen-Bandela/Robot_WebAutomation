*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Variables    ../page_objects/locators.py

*** Variables ***
${TEST_DATA_FILE}    testdata.json

*** Keywords ***
Open Browser To Login Page
    ${data}    Get File    ${TEST_DATA_FILE}
    ${json}    Evaluate    json.loads($data)    json

    ${URL}       Set Variable    ${json["login"]["url"]}
    ${BROWSER}   Set Variable    ${json["login"]["browser"]}
    ${USERNAME}  Set Variable    ${json["login"]["username"]}
    ${PASSWORD}  Set Variable    ${json["login"]["password"]}
    ${HEADLESS}  Set Variable    ${json["login"].get("headless", False)}

    # Create Chrome options
    ${chrome_options}    Evaluate    selenium.webdriver.ChromeOptions()    selenium.webdriver

    # Add arguments based on the headless flag
    Run Keyword If    "${HEADLESS}" == "True"    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
   #Call Method    ${chrome_options}    add_argument    "--remote-allow-origins=*"
    Call Method    ${chrome_options}    add_argument    --disable-infobars
   #Call Method    ${chrome_options}    add_argument    "--window-size=1920,1080"

    Log    Loaded test data: ${json}  # Debugging step

    # Open Browser with options
    Open Browser    ${URL}    ${BROWSER}    options=${chrome_options}
    Maximize Browser Window
    Wait Until Page Contains Element    ${txtEmail}    timeout=10s

Enter Credentials And Login
    [Arguments]    ${email}    ${password}
    Input Text    ${txtEmail}    ${email}
    Input Text    ${txtPassowrd}    ${password}
    Click Element    ${btnLogin}
    Wait Until Page Contains Element    ${headerDashboard}    timeout=10s

Verify Dashboard Page
    Element Should Be Visible    ${headerDashboard}

Click On Data Integration
    Click Element    ${lnkDataIntegration}

Upload A Document
    [Arguments]    ${file_path}
    ${CANONICAL_PATH}    Normalize Path    ${file_path}
    Choose File    ${inputCustomerDataFile}    ${CANONICAL_PATH}
    #Click Button    ${btnUpload}
