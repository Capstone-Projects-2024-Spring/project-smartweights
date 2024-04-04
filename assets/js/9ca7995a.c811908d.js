"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[1996],{99012:(e,s,t)=>{t.r(s),t.d(s,{assets:()=>a,contentTitle:()=>o,default:()=>d,frontMatter:()=>r,metadata:()=>l,toc:()=>h});var i=t(85893),n=t(11151);const r={sidebar_position:2},o="Integration tests",l={id:"testing/integration-testing",title:"Integration tests",description:"Tests to demonstrate each use-case based on the use-case descriptions and the sequence diagrams. External input should be provided via mock objects and results verified via mock objects. Integration tests should not require manual entry of data nor require manual interpretation of results.",source:"@site/docs/testing/integration-testing.md",sourceDirName:"testing",slug:"/testing/integration-testing",permalink:"/project-smartweights/docs/testing/integration-testing",draft:!1,unlisted:!1,editUrl:"https://github.com/Capstone-Projects-2024-Spring/project-smartweights/edit/main/documentation/docs/testing/integration-testing.md",tags:[],version:"current",lastUpdatedBy:"Daniel Eap",sidebarPosition:2,frontMatter:{sidebar_position:2},sidebar:"docsSidebar",previous:{title:"Unit tests",permalink:"/project-smartweights/docs/testing/unit-testing"},next:{title:"Acceptance test",permalink:"/project-smartweights/docs/testing/acceptence-testing"}},a={},h=[{value:"Assertions",id:"assertions",level:2},{value:"Assertions",id:"assertions-1",level:2},{value:"Assertions",id:"assertions-2",level:2},{value:"Assertions",id:"assertions-3",level:2},{value:"Assertions",id:"assertions-4",level:2},{value:"Assertions",id:"assertions-5",level:2},{value:"Assertions",id:"assertions-6",level:2},{value:"Assertions",id:"assertions-7",level:2},{value:"Assertions",id:"assertions-8",level:2},{value:"Assertions",id:"assertions-9",level:2},{value:"Assertions",id:"assertions-10",level:2},{value:"Assertions",id:"assertions-11",level:2},{value:"Assertions",id:"assertions-12",level:2},{value:"Assertions",id:"assertions-13",level:2}];function c(e){const s={h1:"h1",h2:"h2",li:"li",ol:"ol",p:"p",ul:"ul",...(0,n.a)(),...e.components},{Details:t}=s;return t||function(e,s){throw new Error("Expected "+(s?"component":"object")+" `"+e+"` to be defined: you likely forgot to import, pass, or provide it.")}("Details",!0),(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(s.h1,{id:"integration-tests",children:"Integration tests"}),"\n",(0,i.jsx)(s.p,{children:"Tests to demonstrate each use-case based on the use-case descriptions and the sequence diagrams. External input should be provided via mock objects and results verified via mock objects. Integration tests should not require manual entry of data nor require manual interpretation of results."}),"\n",(0,i.jsx)(s.h1,{id:"use-case-1---account-login",children:"Use Case 1 - Account Login"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to login into their account"}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user is presented with the login page."}),"\n",(0,i.jsx)(s.li,{children:"The user clicks the 'Login with Apple Account' button."}),"\n",(0,i.jsx)(s.li,{children:"The user enters their account info."}),"\n",(0,i.jsx)(s.li,{children:"The server verified the account."}),"\n",(0,i.jsx)(s.li,{children:"The user can continue into the app."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"After the user logins to the app, they will be routed to the Home Page"}),"\n",(0,i.jsx)(s.li,{children:"The user's information will be cached onto the phone's storage to retain login information for the next time they open the app."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-2---tutorial",children:"Use Case 2 - Tutorial"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user has already created a SmartWeights account and has logged in for the first time."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user logs into their SmartWeights account for the first time."}),"\n",(0,i.jsx)(s.li,{children:"The app displays a generic virtual pet that will guide the user through the application."}),"\n",(0,i.jsx)(s.li,{children:"The virtual pet highlights key features of the application."}),"\n",(0,i.jsx)(s.li,{children:"The user finishes the tutorial."}),"\n",(0,i.jsx)(s.li,{children:"The user is prompted to create their virtual pet."}),"\n",(0,i.jsx)(s.li,{children:"The user finishes the virtual pet creation process and is returned to the main navigation screen."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-1",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"The user will be routed through multiple different tabs/pages of the app while being guided by the pet"}),"\n",(0,i.jsx)(s.li,{children:"After the tutorial is done, there will be information cached onto the phone's storage to prevent the tutorial from happening again several times"}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-3---profile-management",children:"Use Case 3 - Profile Management"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to change their profile settings and workout goals."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user selects the Profile tab."}),"\n",(0,i.jsx)(s.li,{children:"From there, the user can see all their settings and workout goals."}),"\n",(0,i.jsx)(s.li,{children:"The user selects the pencil icon next to the setting."}),"\n",(0,i.jsx)(s.li,{children:"The user edits the desired setting."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-2",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"The user should see all setting options as well as the workout goals they created"}),"\n",(0,i.jsx)(s.li,{children:"When the user edits any setting, the updated information will be saved and some of the information will transfer to the database"}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-4---importing-data-from-apple-health-to-smartweight-app",children:"Use Case 4 - Importing Data From Apple Health to SmartWeight App"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"User decides to integrate their SmartWeight app with Apple Health to import fitness and health data for a comprehensive overview of their wellness journey."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user navigates to the settings."}),"\n",(0,i.jsx)(s.li,{children:"The user selects the option to link the SmartWeight app with Apple Health."}),"\n",(0,i.jsx)(s.li,{children:"iOS will prompt the user to authorize access to the required data from Apple Health."}),"\n",(0,i.jsx)(s.li,{children:"The user grants permission for the SmartWeight app to access the specified data from Apple Health."}),"\n",(0,i.jsx)(s.li,{children:"iOS automatically begins importing the user\u2019s health and fitness data from Apple Health into the SmartWeight app."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-3",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"The Apple Health statistics/information will transfer over to the Smart Weights app"}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-5---attaching-sensors",children:"Use Case 5 - Attaching Sensors"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to prepare for a workout by attaching sensors appropriately."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user gets the dumbbells and elbow sleeve they want to use."}),"\n",(0,i.jsx)(s.li,{children:"The user attaches the sensors to the heads of the dumbbell, locking it in securely."}),"\n",(0,i.jsx)(s.li,{children:"The user puts on the elbow sleeve."}),"\n",(0,i.jsx)(s.li,{children:"The user attaches the sensor to the elbow sleeve."}),"\n",(0,i.jsx)(s.li,{children:"The user attaches another sensor to their chest."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-4",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"User will have all sensors set up on their body and equipment"}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-6---syncing-sensors",children:"Use Case 6 - Syncing Sensors"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to sync their SmartWeights sensor with the mobile app."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user securely attaches the SmartWeight sensor to their dumbbell following the instructions provided via the mobile app."}),"\n",(0,i.jsx)(s.li,{children:"The user navigates to the Devices section on the app to initiate the addition of a new sensor."}),"\n",(0,i.jsx)(s.li,{children:"Within the app, the user selects the option to Add New Sensor. The app will provide instructions to ensure the sensor is on and in the pairing mode."}),"\n",(0,i.jsx)(s.li,{children:"The app will search for available sensors. The user selects their sensor from the list of available devices to start the pairing process."}),"\n",(0,i.jsx)(s.li,{children:"Once the user selects their sensor, the app establishes a connection via Bluetooth. A confirmation message is displayed to the user indicating that the sensor is successfully synced."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-5",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"User receives a confirmation message displaying the sensor is successfully synced."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-7---logging-dumbbell-weight",children:"Use Case 7 - Logging Dumbbell Weight"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"User wants to log the weights of dumbbells used during a workout for tracking progress over time, independent of immediate feedback on form or technique."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"After selecting a workout type, the user is prompted to input the weight of the dumbbells they will use."}),"\n",(0,i.jsx)(s.li,{children:"User enters the weights of the dumbbells into the app before starting the workout."}),"\n",(0,i.jsx)(s.li,{children:"The user begins their workout session without further interaction with the app, focusing on their exercise routine."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-6",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"The correct dumbbell weight is displayed within the workout page's UI."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-8---starting-a-workout-via-siri-voice-command",children:"Use Case 8 - Starting a Workout via Siri Voice Command"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"User wants to start a workout session without manually interacting with their smartphone, using a voice command through Siri while already in position to lift weights."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"User, in position to start lifting and without the need to interact with the device manually, says, \u201cHey Siri, Start my workout\u201d."}),"\n",(0,i.jsx)(s.li,{children:"Siri processes the command and interface with the SmartWeights app to initiate the workout session based on the user's predefined settings or default workout plan."}),"\n",(0,i.jsx)(s.li,{children:"The SmartWeights app activates the workout mode, starts recording the session, including the detection of lifting form, repetitions, and other relevant data using the attached sensors."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-7",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"After completing a workout, post-workout analysis is displayed to the screen."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-9---performing-workout",children:"Use Case 9 - Performing Workout"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to complete a workout with the assistance of the virtual pet."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user navigates to the workout section."}),"\n",(0,i.jsx)(s.li,{children:"The user completes their repetitions and the SmartWeights application tracks how many reps are completed."}),"\n",(0,i.jsx)(s.li,{children:"The virtual pet notifies the user if their form is incorrect."}),"\n",(0,i.jsx)(s.li,{children:"Once finished, the user ends the workout and the SmartWeights application generates a personalized report and summary of the workout for the user."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-8",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"A personalized report and summary of the workout is generated for the user."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-10---view-workout-feedback",children:"Use Case 10 - View Workout Feedback"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to view feedback post-workout."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"After completing a workout, the user selects the post-workout feedback button in the mobile application."}),"\n",(0,i.jsx)(s.li,{children:"Once in, the user selects the date to receive workout feedback for that day."}),"\n",(0,i.jsx)(s.li,{children:"From this page, The user will then be able to view feedback on their form and the number of reps they completed."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-9",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"The user can select a date from the dropdown menu."}),"\n",(0,i.jsx)(s.li,{children:"The workout feedback for the date is displayed."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-11---purchasing-pet-cosmetics",children:"Use Case 11 - Purchasing Pet Cosmetics"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to purchase cosmetics for their virtual pet."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user navigates to the virtual pet store."}),"\n",(0,i.jsx)(s.li,{children:"The app displays cosmetics by category for the user to inspect."}),"\n",(0,i.jsx)(s.li,{children:"The user sees each cosmetic\u2019s price and clicks the buy button on the desired cosmetic."}),"\n",(0,i.jsx)(s.li,{children:"The user has enough currency for the transaction, so the cosmetic is removed from the store and placed into the user\u2019s virtual pet inventory."}),"\n",(0,i.jsx)(s.li,{children:"The price of the cosmetic is deducted from the user\u2019s total currency."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-10",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"User is able to navigate the cosmetic menu."}),"\n",(0,i.jsx)(s.li,{children:"User has the ability to purchase cosmetics given adequate funds."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-12---virtual-pet-customization",children:"Use Case 12: - Virtual Pet Customization"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to customize their virtual pet."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user taps on the Virtual Pet button."}),"\n",(0,i.jsx)(s.li,{children:"The user can tap an inventory button to look at what they currently have equipped/own."}),"\n",(0,i.jsx)(s.li,{children:"The user will then select any costume/accessory they want to equip for their pet."}),"\n",(0,i.jsx)(s.li,{children:"The user will see their pet change according to the costumes/accessories they picked."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-11",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"User is able to open and navigate their inventory when pressing the inventory button."}),"\n",(0,i.jsx)(s.li,{children:"Pet visuals are updated after user equips an accessory."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-13---participating-in-weekly-challenge",children:"Use Case 13 - Participating in Weekly Challenge"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"The SmartWeight app introduces a weekly challenge feature to engage users in varied fitness activities, encouraging consistency and community interaction."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user navigates to the challenges section within the app and opts into the weekly challenge."}),"\n",(0,i.jsx)(s.li,{children:"Once opted in, the user can view detailed information about the challenge, which includes details of the challenge (e.g. total weight lifted, number of workouts completed) and potential reward (e.g. digital currency, virtual pet accessories)."}),"\n",(0,i.jsx)(s.li,{children:"Throughout the week, the user engages in their regular workouts, with the app automatically tracking their progress toward the challenge goals using the integrated sensors."}),"\n",(0,i.jsx)(s.li,{children:"The user can check their current standings in the challenge via the app(challenge tab), which updates in real time, showing their progress."}),"\n",(0,i.jsx)(s.li,{children:"At the end of the week, the app notifies the user of the challenge outcome. If they have met the challenge criteria, they receive their reward."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-12",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"User can opt into the weekly challenge."}),"\n",(0,i.jsx)(s.li,{children:"Visual display shows user progress in weekly challenge."}),"\n",(0,i.jsx)(s.li,{children:"User has the ability to view their current standings in the challenge tab."}),"\n",(0,i.jsx)(s.li,{children:"Notification is received at the end of the week."}),"\n"]}),"\n",(0,i.jsx)("br",{}),"\n",(0,i.jsx)(s.h1,{id:"use-case-14---share-with-friends",children:"Use Case 14 - Share with Friends"}),"\n",(0,i.jsxs)(t,{open:!0,children:[(0,i.jsx)("summary",{children:"A user wants to share their pet/achievements with their friends."}),(0,i.jsxs)(s.ul,{children:["\n",(0,i.jsx)(s.li,{children:"The user selects the Virtual Pet tab."}),"\n",(0,i.jsx)(s.li,{children:"Within the Virtual Pet screen, the user will select the Share Profile button."}),"\n",(0,i.jsx)(s.li,{children:"A jpeg of their profile will appear on the screen."}),"\n",(0,i.jsx)(s.li,{children:"User selects who/how they want to share."}),"\n",(0,i.jsx)(s.li,{children:"Profile is sent."}),"\n"]})]}),"\n",(0,i.jsx)(s.h2,{id:"assertions-13",children:"Assertions"}),"\n",(0,i.jsxs)(s.ol,{children:["\n",(0,i.jsx)(s.li,{children:"JPEG of user profile appears when Share Profile button is pressed."}),"\n",(0,i.jsx)(s.li,{children:"User can choose who they want to send their profile to."}),"\n",(0,i.jsx)(s.li,{children:"User can choose how they want to send their profile."}),"\n",(0,i.jsx)(s.li,{children:"Profile link can be viewed by receiver."}),"\n"]}),"\n",(0,i.jsx)("br",{})]})}function d(e={}){const{wrapper:s}={...(0,n.a)(),...e.components};return s?(0,i.jsx)(s,{...e,children:(0,i.jsx)(c,{...e})}):c(e)}},11151:(e,s,t)=>{t.d(s,{Z:()=>l,a:()=>o});var i=t(67294);const n={},r=i.createContext(n);function o(e){const s=i.useContext(r);return i.useMemo((function(){return"function"==typeof e?e(s):{...s,...e}}),[s,e])}function l(e){let s;return s=e.disableParentContext?"function"==typeof e.components?e.components(n):e.components||n:o(e.components),i.createElement(r.Provider,{value:s},e.children)}}}]);