*** Settings ***
Documentation    Variables for Demo master project



*** Variables ***
${URL}                  http://192.168.101.104:8080/
${BROWSER}              chrome    #headless chrome    #edge
${REGISTRATION}         xpath:/html/body/nav/ul/li[1]/a
${LOGIN}                xpath:/html/body/nav/ul/li[2]/a
${USERNAME}             henrooo96
${PASSWORD}             1234554321
${USERNAME_FIELD}       id:username
${PASSWORD_FIELD}       id:password
${FIRSTNAME_FIELD}      name:firstname
${FAMILYNAME_FIELD}     id:lastname
${FIRSTNAME}            Chukwuebuka
${FAMILYNAME}           Aneke
${PHONE_FIELD}          id:phone
${PHONE_NUMBER}         0401541483
${REGISTER}             xpath:/html/body/section/form/input[6]
${SignIn}               xpath:/html/body/section/form/input[3]