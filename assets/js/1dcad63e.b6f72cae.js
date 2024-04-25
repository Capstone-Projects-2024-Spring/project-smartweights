"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[8968],{12549:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>a,default:()=>h,frontMatter:()=>r,metadata:()=>o,toc:()=>l});var i=n(85893),s=n(11151);const r={sidebar_position:3},a="Sequence Diagrams",o={id:"system-architecture/sequence-diagrams",title:"Sequence Diagrams",description:"Use Case 1 - Account Login",source:"@site/docs/system-architecture/sequence-diagrams.md",sourceDirName:"system-architecture",slug:"/system-architecture/sequence-diagrams",permalink:"/project-smartweights/docs/system-architecture/sequence-diagrams",draft:!1,unlisted:!1,editUrl:"https://github.com/Capstone-Projects-2024-Spring/project-smartweights/edit/main/documentation/docs/system-architecture/sequence-diagrams.md",tags:[],version:"current",lastUpdatedBy:"Adam Ra",sidebarPosition:3,frontMatter:{sidebar_position:3},sidebar:"docsSidebar",previous:{title:"System Architecture",permalink:"/project-smartweights/docs/category/system-architecture"},next:{title:"Development Environment",permalink:"/project-smartweights/docs/system-architecture/development-environment"}},c={},l=[{value:"Use Case 1 - Account Login",id:"use-case-1---account-login",level:3},{value:"Use Case 2 - Tutorial and Pet Selection",id:"use-case-2---tutorial-and-pet-selection",level:3},{value:"Use Case 3 - Profile Management",id:"use-case-3---profile-management",level:3},{value:"Use Case 4 - Connecting Sensors",id:"use-case-4---connecting-sensors",level:3},{value:"Use Case 5 - Logging Dumbbell Weight",id:"use-case-5---logging-dumbbell-weight",level:3},{value:"Use Case 6 - Starting a Workout via voice command",id:"use-case-6---starting-a-workout-via-voice-command",level:3},{value:"Use Case 7 - Performing Workout",id:"use-case-7---performing-workout",level:3},{value:"Use Case 8 - View Workout Feedback History",id:"use-case-8---view-workout-feedback-history",level:3},{value:"Use Case 9 - Purchasing Pet Cosmetics",id:"use-case-9---purchasing-pet-cosmetics",level:3},{value:"Use Case 10: - Virtual Pet Customization",id:"use-case-10---virtual-pet-customization",level:3},{value:"Use Case 11 - Participating in Weekly Challenge",id:"use-case-11---participating-in-weekly-challenge",level:3},{value:"Use Case 12 - Share with Friends",id:"use-case-12---share-with-friends",level:3}];function p(e){const t={h1:"h1",h3:"h3",li:"li",mermaid:"mermaid",ol:"ol",p:"p",...(0,s.a)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(t.h1,{id:"sequence-diagrams",children:"Sequence Diagrams"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-1---account-login",children:"Use Case 1 - Account Login"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to login into their account."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user is presented with the login page."}),"\n",(0,i.jsx)(t.li,{children:"The user clicks the 'Login with Apple Account' button."}),"\n",(0,i.jsx)(t.li,{children:"The user enters their account info."}),"\n",(0,i.jsx)(t.li,{children:"The server verified the account."}),"\n",(0,i.jsx)(t.li,{children:"The user is able to continue into the app."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    participant Server\n\n    activate User\n    activate App\n    User->>App: Click 'Login with Apple Account' button\n    App->>Server: Request login verification\n    activate Server\n    Server--\x3e>App: Verify user account\n    deactivate Server\n    alt Account verified\n        App--\x3e>User: Display successful login message\n    else Account not verified\n        App--\x3e>User: Display login error message\n    end\n    deactivate User\n    deactivate App\n\n"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-2---tutorial-and-pet-selection",children:"Use Case 2 - Tutorial and Pet Selection"}),"\n",(0,i.jsx)(t.p,{children:"A user has successfully logged in for the first time."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user logs into their SmartWeights account for the first time."}),"\n",(0,i.jsx)(t.li,{children:"The app displays a generic virtual pet that will guide the user through the application."}),"\n",(0,i.jsx)(t.li,{children:"The virtual pet highlights key features of the application."}),"\n",(0,i.jsx)(t.li,{children:"The user finishes the tutorial."}),"\n",(0,i.jsx)(t.li,{children:"The user is prompted to select their first virtual pet."}),"\n",(0,i.jsx)(t.li,{children:"The user finishes the virtual pet selection process and is returned to the main navigation screen."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    participant Server\n    activate User\n    activate App\n\n    User->>App: Log in to SmartWeights account\n    App->>Server: Validate login credentials\n    activate Server\n    Server--\x3e>App: Credentials validated\n    deactivate Server\n    App--\x3e>User: Display generic virtual pet\n    loop Tutorial\n        App--\x3e>User: Virtual pet highlights key features\n    end\n    User->>App: Finish tutorial\n\n    App--\x3e>User: Prompt to select first virtual pet\n    User->>App: Start virtual pet selection process\n    App->>App: Initialize virtual pet selection\n    User->>App: Select first virtual pet\n    App->>App: Set virtual pet details\n    App--\x3e>User: Virtual pet selected successfully\n    User->>App: Return to main navigation screen\n\n    deactivate User\n    deactivate App\n"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-3---profile-management",children:"Use Case 3 - Profile Management"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to change their profile settings and workout goals."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user selects the Profile tab."}),"\n",(0,i.jsx)(t.li,{children:"From there, the user can see all their settings and workout goals."}),"\n",(0,i.jsx)(t.li,{children:"The user selects the pencil icon next to the setting."}),"\n",(0,i.jsx)(t.li,{children:"The user edits the desired setting."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    participant Server\n   \n\n   activate User\n   activate App\n    User->>App: Select Profile tab\n    App->>Server: Retrieve user profile information\n    activate Server\n    Server--\x3e>App: User profile information retrieved\n    deactivate Server\n    App--\x3e>User: Display user settings and workout goals\n    User->>App: Select pencil icon next to setting\n    App--\x3e>User: Display settings tab\n    User->>App: Edit desired setting\n    App->>Server: Send updated setting to server\n    activate Server\n    Server--\x3e>App: Setting updated successfully\n    deactivate Server\n    App--\x3e>User: Display confirmation message\n\n    deactivate User\n    deactivate App"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-4---connecting-sensors",children:"Use Case 4 - Connecting Sensors"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to connect their SmartWeights sensors with the mobile app."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user securely attaches the SmartWeight sensor to their dumbbell following the instructions provided via the mobile app."}),"\n",(0,i.jsx)(t.li,{children:"The user turns on all the sensors."}),"\n",(0,i.jsx)(t.li,{children:"Upon navigating the to workout page, the app will ask the user to allow bluetooth."}),"\n",(0,i.jsx)(t.li,{children:"After enabling bluetooth, the app will automatically connect to the sensors."}),"\n",(0,i.jsx)(t.li,{children:"The user will be notified that the sensors are connected."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    participant Sensors\n    \n    activate User\n    activate App\n\n    User->>Sensors: Securely attach SmartWeights sensor to dumbbell\n    User->>Sensors: Turn on all sensors\n    activate Sensors\n    User->>App: Allow Bluetooth\n    App->>Sensors: Search for sensors\n    Sensors--\x3e>App: Broadcasting sensors\n    App->>Sensors: Connects to sensors via Bluetooth\n    Sensors--\x3e>App: Establish Bluetooth connection\n    App--\x3e>User: Display confirmation message\n\n    deactivate User\n    deactivate App\n    deactivate Sensors"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-5---logging-dumbbell-weight",children:"Use Case 5 - Logging Dumbbell Weight"}),"\n",(0,i.jsx)(t.p,{children:"User wants to log the weights of dumbbells used during a workout for tracking progress over time."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"On the workout page, the user is prompted to enter their dumbbell weight for the workout."}),"\n",(0,i.jsx)(t.li,{children:"The user inputs the dumbbell weight for the workout."}),"\n",(0,i.jsx)(t.li,{children:"The user begins their workout session without further interaction with the app, focusing on their exercise routine."}),"\n",(0,i.jsx)(t.li,{children:"The dumbbell weight gets logged into their workout history."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n\n    activate User\n    activate App\n    App--\x3e>User: Prompt to input dumbbell weight\n    User->>App: Enter dumbbell weight\n    App--\x3e>User: confirmed weight input\n    User->>App: Start workout session\n    App->>App: Log dumbbell weight into workout history\n\n    deactivate User\n    deactivate App\n    "}),"\n",(0,i.jsx)(t.h3,{id:"use-case-6---starting-a-workout-via-voice-command",children:"Use Case 6 - Starting a Workout via voice command"}),"\n",(0,i.jsx)(t.p,{children:"User wants to start a workout session without manually interacting with their smartphone, using a voice command through SmartWeights while already in position to lift weights."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user clicks the microphone button to have SmartWeights listen to voice commands."}),"\n",(0,i.jsx)(t.li,{children:"The user, in position to start lifting and without the need to interact with the device manually, says, \u201cStart workout\u201d."}),"\n",(0,i.jsx)(t.li,{children:"The app processes the command and initiate the workout session."}),"\n",(0,i.jsx)(t.li,{children:"The SmartWeights app activates the workout mode, starts recording the session, including the detection of lifting form, and other relevant data using the attached sensors."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:'sequenceDiagram\n    participant User\n    participant App\n\n    activate User\n    activate App\n    activate Sensors\n    User->>App: Clicks microphone button\n    App--\x3e> User: Listens for voice commands\n    User->>App: "Start workout"\n    App->>Sensors: Initiate workout\n    Sensors --\x3e> App: Send data to App\n\n  \n\n    deactivate User\n    deactivate App\n    deactivate Sensors\n'}),"\n",(0,i.jsx)(t.h3,{id:"use-case-7---performing-workout",children:"Use Case 7 - Performing Workout"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to complete a workout with the assistance of the virtual pet."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user navigates to the workout page."}),"\n",(0,i.jsx)(t.li,{children:"The user finishes their workout set and looks for the virtual pet to give feedback."}),"\n",(0,i.jsx)(t.li,{children:"The virtual pet notifies the user if their form is incorrect."}),"\n",(0,i.jsx)(t.li,{children:"Once finished, the user ends the workout and the SmartWeights application generates a personalized report and summary of the workout for the user."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    \n    activate User\n    activate App\n    User->>App: Navigates to Workout page\n    User->>App: Finishes workout set\n    App--\x3e>User: Virtual Pet gives user feedback\n    User->>App: Ends workout\n    App--\x3e>User: Gives workout summary\n\n\n\n    deactivate User\n    deactivate App\n    "}),"\n",(0,i.jsx)(t.h3,{id:"use-case-8---view-workout-feedback-history",children:"Use Case 8 - View Workout Feedback History"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to view their workout history."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"After completing a workout, the user selects the Workout Feedback History button in the mobile application."}),"\n",(0,i.jsx)(t.li,{children:"Once in, the user selects the date to receive workout feedback for that day."}),"\n",(0,i.jsx)(t.li,{children:"From this page, The user will then be able to view feedback on their form and data related to that day."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n\n    activate User\n    activate App\n\n    User->>App: Select the workout Feedback History Button\n    App--\x3e>User: Display dates to pick from \n    User->>App: Select date for feedback\n    App--\x3eUser: Display workout feedback for selected date\n\n    deactivate User\n    deactivate App\n\n\n    "}),"\n",(0,i.jsx)(t.h3,{id:"use-case-9---purchasing-pet-cosmetics",children:"Use Case 9 - Purchasing Pet Cosmetics"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to purchase cosmetics for their virtual pet."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user navigates to the virtual pet store."}),"\n",(0,i.jsx)(t.li,{children:"The app displays cosmetics by category for the user to inspect."}),"\n",(0,i.jsx)(t.li,{children:"The user sees each cosmetic\u2019s price and clicks the buy button on the desired cosmetic."}),"\n",(0,i.jsx)(t.li,{children:"The user has enough currency for the transaction, so the cosmetic is removed from the store and placed into the user\u2019s virtual pet inventory."}),"\n",(0,i.jsx)(t.li,{children:"The price of the cosmetic is deducted from the user\u2019s total currency."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    \n    activate User\n    activate App\n\n    User->>App: Navigate to virtual pet store\n    App--\x3e>User: Display cosmetics by category\n    User->>App: Inspect cosmetics\n    User->>App: Check availability and price\n    App --\x3e> User: Cosmetic available\n    User->>App: Click buy button on desired cosmetic\n    App--\x3e>User: Add cosmetic to user's inventory\n    App--\x3e>User: Deduct price from user's total currency\n\n    deactivate User\n    deactivate App\n\n"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-10---virtual-pet-customization",children:"Use Case 10: - Virtual Pet Customization"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to customize their virtual pet."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user taps on the Virtual Pet button."}),"\n",(0,i.jsx)(t.li,{children:"The user can tap an inventory button to look at what they currently have equipped/own."}),"\n",(0,i.jsx)(t.li,{children:"The user will then select any costume/accessory they want to equip for their pet."}),"\n",(0,i.jsx)(t.li,{children:"The user will see their pet change according to the costumes/accessories they picked."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n\n    activate App\n    activate User\n\n    User->>App: Tap on Virtual Pet button\n    App--\x3e>User: Display virtual pet interface\n    User->>App: Tap on inventory button\n    App--\x3e>User: Display user's equipped/owned items\n    User->>App: Select costume/accessory to equip\n    App--\x3e> User: Change virtual pet's appearance according to selection\n    \n    deactivate User\n    deactivate App\n\n"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-11---participating-in-weekly-challenge",children:"Use Case 11 - Participating in Weekly Challenge"}),"\n",(0,i.jsx)(t.p,{children:"The SmartWeight app introduces a weekly challenge feature to engage users in varied fitness activities, encouraging consistency and community interaction."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user navigates to the challenges section within the app and opts into the weekly challenge."}),"\n",(0,i.jsx)(t.li,{children:"Once opted in, the user can view detailed information about the challenge, which includes details of the challenge (e.g. total weight lifted, number of workouts completed) and potential reward (e.g. digital currency, virtual pet accessories)."}),"\n",(0,i.jsx)(t.li,{children:"Throughout the week, the user engages in their regular workouts, with the app automatically tracking their progress toward the challenge goals using the integrated sensors."}),"\n",(0,i.jsx)(t.li,{children:"The user can check their current standings in the challenge via the app(challenge tab), which updates in real time, showing their progress."}),"\n",(0,i.jsx)(t.li,{children:"At the end of the week, the app notifies the user of the challenge outcome. If they have met the challenge criteria, they receive their reward."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    activate User\n    activate App\n    User->>App: Navigate to challenges section\n    App--\x3e>User: Display list of available challenges\n    User->>App: Opt into weekly challenge\n    App--\x3e>User: Display details of the challenge\n    User->>App: Engage in regular workouts\n    App->>App: Track user's progress\n    loop Throughout the week\n       \n        App--\x3e>User: Display current standings\n    end\n    App->>App: Check challenge completion status\n    App--\x3e>User: Challenge completed\n    User->>App: Claim reward if challenge criteria met\n\n    deactivate User\n    deactivate App\n\n"}),"\n",(0,i.jsx)(t.h3,{id:"use-case-12---share-with-friends",children:"Use Case 12 - Share with Friends"}),"\n",(0,i.jsx)(t.p,{children:"A user wants to share their pet/achievements with their friends."}),"\n",(0,i.jsxs)(t.ol,{children:["\n",(0,i.jsx)(t.li,{children:"The user selects the Profile tab."}),"\n",(0,i.jsx)(t.li,{children:"Within the Profile screen, the user will select the Share Profile button."}),"\n",(0,i.jsx)(t.li,{children:"A jpeg of their profile will appear on the screen."}),"\n",(0,i.jsx)(t.li,{children:"User selects who/how they want to share."}),"\n",(0,i.jsx)(t.li,{children:"Profile is sent."}),"\n"]}),"\n",(0,i.jsx)(t.mermaid,{value:"sequenceDiagram\n    participant User\n    participant App\n    participant SocialMedia\n\n    activate User\n    activate App\n\n    User->>App: Select Profile tab\n    App--\x3e>User: Display Profile screen\n    User->>App: Select Share Profile button\n    App--\x3e>User: Display profile as JPEG\n    User->>App: Select who/how to share\n    App->>SocialMedia: Send profile\n    activate SocialMedia\n    SocialMedia--\x3e>App: Profile sent successfully\n    deactivate SocialMedia\n    deactivate User\n    deactivate App\n\n\n\n"})]})}function h(e={}){const{wrapper:t}={...(0,s.a)(),...e.components};return t?(0,i.jsx)(t,{...e,children:(0,i.jsx)(p,{...e})}):p(e)}},11151:(e,t,n)=>{n.d(t,{Z:()=>o,a:()=>a});var i=n(67294);const s={},r=i.createContext(s);function a(e){const t=i.useContext(r);return i.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function o(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:a(e.components),i.createElement(r.Provider,{value:t},e.children)}}}]);