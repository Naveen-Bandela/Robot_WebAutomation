*** Settings ***
Documentation   Test login functionality of Utkarsh Bank application
Library         SeleniumLibrary
Library         Collections
Library         OperatingSystem
Resource        ../resources/LoginKeywords.robot

Suite Setup    Open Browser To Login Page
Suite Teardown    Close Browser


*** Variables ***
${TEST_DATA_FILE}    testdata.json

*** Test Cases ***
Login With Valid Credentials
    [Documentation]    Verify that user can log in successfully with valid credentials
    [Tags]    priority=1
    ${data}    Get File    ${TEST_DATA_FILE}
    ${json}    Evaluate    json.loads($data)    json
    ${USERNAME}    Set Variable    ${json["login"]["username"]}
    ${PASSWORD}    Set Variable    ${json["login"]["password"]}
    ${HEADLESS}    Set Variable    ${json["login"]["headless"]}

    Enter Credentials And Login    ${USERNAME}    ${PASSWORD}
    Wait Until Page Contains Element    ${headerDashboard}    timeout=5s
    Verify Dashboard Page

Navigate To Data Integration
    [Documentation]    Click on Data Integration and verify
    [Tags]    priority=2
    Click On Data Integration

Upload Document
    [Documentation]    Upload a file from local system
    [Tags]    priority=3
    Upload A Document    ${CURDIR}/../testdata/Sample.csv
    Log To Console    message=${CURDIR}
