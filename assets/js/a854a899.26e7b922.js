"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[3196],{98379:(e,t,i)=>{i.r(t),i.d(t,{assets:()=>h,contentTitle:()=>r,default:()=>l,frontMatter:()=>o,metadata:()=>n,toc:()=>c});var a=i(85893),s=i(11151);const o={sidebar_position:1},r="System Overview",n={id:"requirements/system-overview",title:"System Overview",description:"Project Abstract",source:"@site/docs/requirements/system-overview.md",sourceDirName:"requirements",slug:"/requirements/system-overview",permalink:"/project-smartweights/docs/requirements/system-overview",draft:!1,unlisted:!1,editUrl:"https://github.com/Capstone-Projects-2024-Spring/project-smartweights/edit/main/documentation/docs/requirements/system-overview.md",tags:[],version:"current",lastUpdatedBy:"Jonathan Stanczak",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"docsSidebar",previous:{title:"Requirements Specification",permalink:"/project-smartweights/docs/category/requirements-specification"},next:{title:"System Block Diagram",permalink:"/project-smartweights/docs/requirements/system-block-diagram"}},h={},c=[{value:"Project Abstract",id:"project-abstract",level:2}];function d(e){const t={h1:"h1",h2:"h2",p:"p",...(0,s.a)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(t.h1,{id:"system-overview",children:"System Overview"}),"\n",(0,a.jsx)(t.h2,{id:"project-abstract",children:"Project Abstract"}),"\n",(0,a.jsx)(t.p,{children:"SmartWeights is a project that presents a comprehensive approach to fitness and virtual pets. The project aims to improve both physical and mental health by helping users fix their form, as well as rewarding them for their hard work."}),"\n",(0,a.jsx)(t.p,{children:"SmartWeights removes the need for a personal trainer through the integration of sensors and dumbbells. It provides users with a set of sensors that can be attached to any dumbbell of their choice. Users will also be provided sensors to attach to their body depending on the exercise of their choice. This allows SmartWeights to capture data about the user\u2019s weight-lifting form and relay it to the SmartWeights mobile app. The application of SmartWeights extends beyond a traditional fitness tracking app by incorporating unique features that track the user\u2019s exercise form and provide feedback after each set. The app will allow the user to create their own virtual pet that will motivate them to continue working out by providing feedback and through the pet\u2019s level-up and customization system. Continuous workouts and progress will award users with a digital currency that they can then use to buy items for their pet. The virtual pet gives working out a fun and motivating experience, as not only do users get physical and mental satisfaction from working out, but they can also visually show their progress and dedication to their friends and family."}),"\n",(0,a.jsx)(t.h1,{id:"conceptual-design",children:"Conceptual Design"}),"\n",(0,a.jsx)(t.p,{children:"SmartWeights will consist of attachable/wearable sensors sending data to an iOS application through Bluetooth; the MPU6050 IMU sensors combine Raspberry Pi Pico W  microcontrollers. These devices are then placed on the dumbbells and the user\u2019s body depending on the exercise to track changes in position during a workout. Using the built-in Bluetooth shield on the Pico, we can then relay the sensors\u2019 information to the paired iOS app."}),"\n",(0,a.jsx)(t.p,{children:"Designed with Swift using SwiftUI, the app will process the data and display feedback on the user\u2019s weightlifting form. Users will be required to log in with their Apple accounts using Apple\u2019s Sign-In SDK and OAuth. User accounts will be tracked and stored with Apple\u2019s CloudKit service. Users can start their workouts using a voice recognition feature or through a button on the application. SmartWeights is only available on iOS."}),"\n",(0,a.jsx)(t.h1,{id:"background",children:"Background"}),"\n",(0,a.jsx)(t.p,{children:"SmartWeights is a combination of two project proposals, \u201cSmartWeights\u201d and \u201cMarcoBuddy\u201d. The idea for SmartWeights came about from the group\u2019s personal experience with weightlifting and the challenges they faced. Going to the gym can be both intimidating and inaccessible, and SmartWeights aims to solve those issues. There are similar products on the market such as Dribbleup and Kabata, but these products have a huge price point. SmartWeights will try to differentiate itself by providing advanced analytics at a reasonable price point. The idea of MacroBuddy was to create a mobile application that would combine virtual pets and healthy habits. Most health apps that involve a virtual pet only encourage users to get enough daily steps, but there are a multitude of different things that can help users be healthy like working out and eating a good diet. MacroBuddy\u2019s goal was to focus on those other goals and reward users for sticking to their healthy habits. By combining these two ideas, SmartWeights would be a cheap solution for weightlifters and a way to keep them motivated to continue having healthy habits."})]})}function l(e={}){const{wrapper:t}={...(0,s.a)(),...e.components};return t?(0,a.jsx)(t,{...e,children:(0,a.jsx)(d,{...e})}):d(e)}},11151:(e,t,i)=>{i.d(t,{Z:()=>n,a:()=>r});var a=i(67294);const s={},o=a.createContext(s);function r(e){const t=a.useContext(o);return a.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function n(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:r(e.components),a.createElement(o.Provider,{value:t},e.children)}}}]);