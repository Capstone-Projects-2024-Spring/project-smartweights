"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[1270],{64225:(e,n,s)=>{s.r(n),s.d(n,{assets:()=>d,contentTitle:()=>l,default:()=>a,frontMatter:()=>i,metadata:()=>c,toc:()=>o});var t=s(85893),r=s(11151);const i={sidebar_position:1},l="Unit tests",c={id:"testing/unit-testing",title:"Unit tests",description:"Unit tests are done with Swift's XCTest",source:"@site/docs/testing/unit-testing.md",sourceDirName:"testing",slug:"/testing/unit-testing",permalink:"/project-smartweights/docs/testing/unit-testing",draft:!1,unlisted:!1,editUrl:"https://github.com/Capstone-Projects-2024-Spring/project-smartweights/edit/main/documentation/docs/testing/unit-testing.md",tags:[],version:"current",lastUpdatedBy:"Daniel Eap",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"docsSidebar",previous:{title:"Test Procedures",permalink:"/project-smartweights/docs/category/test-procedures"},next:{title:"Integration tests",permalink:"/project-smartweights/docs/testing/integration-testing"}},d={},o=[{value:"Front End",id:"front-end",level:2},{value:"Pet Page",id:"pet-page",level:3},{value:"Workout Main Page",id:"workout-main-page",level:3},{value:"Workout Overall Progress Page",id:"workout-overall-progress-page",level:3},{value:"Pet Store Page",id:"pet-store-page",level:3},{value:"Backend",id:"backend",level:2},{value:"CloudKit DB",id:"cloudkit-db",level:3},{value:"CoreData Local DB",id:"coredata-local-db",level:3},{value:"Machine Learning",id:"machine-learning",level:3},{value:"Hardware-Software",id:"hardware-software",level:3}];function h(e){const n={em:"em",h1:"h1",h2:"h2",h3:"h3",li:"li",p:"p",strong:"strong",ul:"ul",...(0,r.a)(),...e.components},{Details:s}=n;return s||function(e,n){throw new Error("Expected "+(n?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,t.jsxs)(t.Fragment,{children:[(0,t.jsx)(n.h1,{id:"unit-tests",children:"Unit tests"}),"\n",(0,t.jsx)(n.p,{children:"Unit tests are done with Swift's XCTest\nPico testing is done with MicroPython test library\nPython unittest library is used for machine learning"}),"\n",(0,t.jsx)(n.h2,{id:"front-end",children:"Front End"}),"\n",(0,t.jsx)(n.h3,{id:"pet-page",children:"Pet Page"}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" HandleFoodUse() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Health increases after eating food"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is feeding their pets food","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks on food button to feed pet"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"handleFoodUse(selectedFoodIndex: Int) is called, health bar should increase"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Food quantity decreases after eating food"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is feeding their pets food","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks on food button to feed pet"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"handleFoodUse(selectedFoodIndex: Int) is called, food quantity should decrease"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Health should not exceed after eating food"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is feeding their pet with the pet's health bar full","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks on food button to feed pet"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"handleFoodUse(selectedFoodIndex: Int) is called, health bar bar should not exceed full"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Alert users of insufficient amount of food"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is feeding their pets with insufficient amount of food","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks on food button to feed pet"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"handleFoodUse(selectedFoodIndex: Int) is called, an alert pops up telling the user they have no more food"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Alert users that health is at max"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is feeding their pets the health already full","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks on food button to feed pet"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"handleFoodUse(selectedFoodIndex: Int) is called, an alert pops up telling the user that the health bar is already full"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsx)(n.h3,{id:"workout-main-page",children:"Workout Main Page"}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" addProgress() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Workout progress is updated after starting workout"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is starting their workout","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User starts the workout"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"addProgress(data: Int) is called, the form and velocity progress bar changes"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" resetProgress() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Workout progress is reset after starting new workout"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is starting a new workout","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks the 'new workout' button"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"resetProgress() is called, the form and velocity progress bar is reset to zero"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" startTimer() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Workout timer is counting after starting the workout"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is starting the workout","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User starts the working"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"startTimer() is called, the workout timer starts counting"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" resetTimer() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"Workout timer is reset after starting new workout"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is starting a new workout","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks the 'new workout' button"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"resetTimer() is called, the workout timer is reset to 00:00:00"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsx)(n.h3,{id:"workout-overall-progress-page",children:"Workout Overall Progress Page"}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" updateShortDate() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"The date is updated when the user uses the calendar"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user is selecting a date to obtain workout data from that day","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User selects a date on the calendar"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"updateShortDate() is called, the date is updated and matches the format M/D/Y"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsx)(n.h3,{id:"pet-store-page",children:"Pet Store Page"}),"\n",(0,t.jsxs)(s,{open:!0,children:[(0,t.jsx)("summary",{children:" sortItems() "}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"The shop is sorted by name A-Z"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user clicks sort by name to get the items in alphabetical order","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks sort by name"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"sortItems(sortByPrice: false) is called, the items will be sorted in alphabetical order"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),(0,t.jsx)(n.p,{children:(0,t.jsx)(n.em,{children:(0,t.jsx)(n.strong,{children:"The shop is sorted by price lowest-highest"})})}),(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Test user clicks sort by price to get the items from lowest to highest cost","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["Input/User action","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"User clicks sort by price"}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"sortItems(sortedByPrice: true) is called, the items will be sorted by price"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]}),"\n",(0,t.jsx)(n.h2,{id:"backend",children:"Backend"}),"\n",(0,t.jsx)(n.h3,{id:"cloudkit-db",children:"CloudKit DB"}),"\n",(0,t.jsx)(s,{children:(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testConnectToCloudKit()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if the application can connect to CloudKit DB and find the correct container"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns true if successful connection, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testFetchRecord()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if given input parameters can query the CloudKit DB and return a record"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns true if record is not nil, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testFetchRecordAndCheckCurrency()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if given user record has a specified field value"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns values of the record for the parameters match, else return false for no record returned or incorrect record"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testGetReference()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if given a reference value can query the CloudKit DB and return a referenced record"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns values of the record for the parameters, else return false for no record returned or incorrect record"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testAccountCreatedCloud()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if account credentials were stored after login button pressed"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns true if record return with correct ID, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testUpdateCurrency()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if after button press, updates the user's total currency after transaction and updates the DB"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns the same currency as currently stored on local model from the DB, else return false if different value or no value returned"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testUploadImage()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if a CKAsset was successfully uploaded to CloudKit DB"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns a successful entry, else false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["\n",(0,t.jsx)(n.p,{children:"testFetchImage()"}),"\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if can fetch a CKAsset from CloudKit DB"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns a binary CKAsset, else false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})}),"\n",(0,t.jsx)(n.h3,{id:"coredata-local-db",children:"CoreData Local DB"}),"\n",(0,t.jsx)(s,{children:(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["testAccountCreatedLocal()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if account credentials were created after login button pressed"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns true if file was created with credentials, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["testInsertSensorData()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if data received from Pico can be inserted into CoreData DB"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns true if DB returns successful entry, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["testFetchData()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if can retrieve data from DB"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Returns true if DB returns an object of data, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})}),"\n",(0,t.jsx)(n.h3,{id:"machine-learning",children:"Machine Learning"}),"\n",(0,t.jsx)(s,{children:(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["testConvert()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test to see if can take data from CoreData and convert to tensors"}),"\n",(0,t.jsx)(n.li,{children:"Returns true if tensor is created"}),"\n"]}),"\n"]}),"\n"]})}),"\n",(0,t.jsx)(n.h3,{id:"hardware-software",children:"Hardware-Software"}),"\n",(0,t.jsx)(s,{children:(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsxs)(n.li,{children:["testBluetoothConnectionPico()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test if Pico establishes a successful connection to mobile device acting as a server"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Return true if connection before time out, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["testBluetoothConnectionMobile()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test if mobile device connects to pico, acting as a client"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Return true if connection before time out, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["testMultiSensorConnection()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test if Pico can connect to another Pico"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Return true if successful message received, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["testTransmitData()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test if Pico can transmit data through the socket"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Return true if data was sent through socket, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,t.jsxs)(n.li,{children:["testReadData()","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Test if mobile device received any data from the pico"}),"\n",(0,t.jsxs)(n.li,{children:["Expected Result","\n",(0,t.jsxs)(n.ul,{children:["\n",(0,t.jsx)(n.li,{children:"Return true if data contained specifically integers in specified structure, else return false"}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})})]})}function a(e={}){const{wrapper:n}={...(0,r.a)(),...e.components};return n?(0,t.jsx)(n,{...e,children:(0,t.jsx)(h,{...e})}):h(e)}},11151:(e,n,s)=>{s.d(n,{Z:()=>c,a:()=>l});var t=s(67294);const r={},i=t.createContext(r);function l(e){const n=t.useContext(i);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function c(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:l(e.components),t.createElement(i.Provider,{value:n},e.children)}}}]);