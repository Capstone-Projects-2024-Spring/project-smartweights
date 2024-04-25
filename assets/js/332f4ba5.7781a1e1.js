"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[720],{22390:(e,n,i)=>{i.r(n),i.d(n,{assets:()=>c,contentTitle:()=>o,default:()=>h,frontMatter:()=>t,metadata:()=>l,toc:()=>d});var s=i(85893),r=i(11151);const t={},o="Hardware Software",l={id:"api-specification/hardware-software",title:"Hardware Software",description:"Class BluetoothManager",source:"@site/docs/api-specification/hardware-software.md",sourceDirName:"api-specification",slug:"/api-specification/hardware-software",permalink:"/project-smartweights/docs/api-specification/hardware-software",draft:!1,unlisted:!1,editUrl:"https://github.com/Capstone-Projects-2024-Spring/project-smartweights/edit/main/documentation/docs/api-specification/hardware-software.md",tags:[],version:"current",lastUpdatedBy:"Adam Ra",frontMatter:{},sidebar:"docsSidebar",previous:{title:"Local CoreData Database",permalink:"/project-smartweights/docs/api-specification/database-integration/Local-coredata-database"},next:{title:"mobile-backend",permalink:"/project-smartweights/docs/api-specification/mobile-backend"}},c={},d=[{value:"Class BluetoothManager",id:"class-bluetoothmanager",level:2},{value:"Class Description",id:"class-description",level:3},{value:"Data Fields",id:"data-fields",level:4},{value:"Methods",id:"methods",level:4},{value:"Class Pico",id:"class-pico",level:2},{value:"Class Description",id:"class-description-1",level:3},{value:"Data Fields",id:"data-fields-1",level:4},{value:"Methods",id:"methods-1",level:4}];function a(e){const n={code:"code",h1:"h1",h2:"h2",h3:"h3",h4:"h4",li:"li",p:"p",ul:"ul",...(0,r.a)(),...e.components};return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(n.h1,{id:"hardware-software",children:"Hardware Software"}),"\n",(0,s.jsx)(n.h2,{id:"class-bluetoothmanager",children:"Class BluetoothManager"}),"\n",(0,s.jsx)(n.p,{children:"The BluetoothManager class provides methods for establishing a Bluetooth connection with a Raspberry Pi Pico Wand receiving data."}),"\n",(0,s.jsx)(n.h3,{id:"class-description",children:"Class Description"}),"\n",(0,s.jsx)(n.h4,{id:"data-fields",children:"Data Fields"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:[(0,s.jsx)(n.code,{children:"shared"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Singleton instance of the BluetoothManager class."}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:[(0,s.jsx)(n.code,{children:"receivedData"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose : Object of the data received from the hardware system"}),"\n",(0,s.jsx)(n.li,{children:"Type: List: [Integer]"}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.h4,{id:"methods",children:"Methods"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"connectToDevice(deviceName:completion:)"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Connects to a Bluetooth device with the given name."}),"\n",(0,s.jsx)(n.li,{children:"Pre-conditions: Bluetooth is enabled on the device."}),"\n",(0,s.jsx)(n.li,{children:"Post-conditions: Bluetooth connection is established or error is returned."}),"\n",(0,s.jsxs)(n.li,{children:["Parameters:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"deviceID (Int): The ID of the Bluetooth device (e.g., Raspberry Pi Pico)."}),"\n",(0,s.jsx)(n.li,{children:"completion (Closure): A closure that takes an optional BluetoothDevice and an optional Error as its parameters."}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.li,{children:"Return Value: None"}),"\n",(0,s.jsxs)(n.li,{children:["Exceptions Thrown:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"BluetoothError: Generic error related to Bluetooth connectivity."}),"\n",(0,s.jsx)(n.li,{children:"DeviceNotFoundError: Error occurs when the specified device is not found."}),"\n",(0,s.jsx)(n.li,{children:"NetworkError: Error occurs when there's an issue with the network connection."}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"receiveData(completion:)"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Receives data from the connected Bluetooth device."}),"\n",(0,s.jsx)(n.li,{children:"Pre-conditions: Bluetooth connection is established."}),"\n",(0,s.jsx)(n.li,{children:"Post-conditions: Data is received from the device or error is returned. Sets receivedData element to data."}),"\n",(0,s.jsxs)(n.li,{children:["Parameters:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"completion (Closure): A closure that takes an optional array of elements received from the device and an optional Error as its parameters."}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.li,{children:"Return Value: None"}),"\n",(0,s.jsxs)(n.li,{children:["Exceptions Thrown:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"BluetoothError: Generic error related to Bluetooth connectivity."}),"\n",(0,s.jsx)(n.li,{children:"DataError: Error occurs when there's an issue with receiving data."}),"\n",(0,s.jsx)(n.li,{children:"NetworkError: Error occurs when there's an issue with the network connection."}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsxs)(n.p,{children:[(0,s.jsx)(n.code,{children:"sendDataToDatabase(completion:)"}),"-"]}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Purpose: Sends the received data to the database."}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Pre-conditions: Data has been received from the Bluetooth device."}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Post-conditions: Data is sent to the database or error is returned."}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Parameters:"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"completion (Closure): A closure that takes an optional Error as its parameter."}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Return Value: None"}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Exceptions Thrown:"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"DatabaseError: Generic error related to database connectivity."}),"\n",(0,s.jsx)(n.li,{children:"NetworkError: Error occurs when there's an issue with the network connection."}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"disconnect(completion:)"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Disconnects from the currently connected Bluetooth device."}),"\n",(0,s.jsx)(n.li,{children:"Pre-conditions: Bluetooth connection is established."}),"\n",(0,s.jsx)(n.li,{children:"Post-conditions: Bluetooth connection is closed."}),"\n",(0,s.jsxs)(n.li,{children:["Parameters:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"completion (Closure): A closure that takes an optional Error as its parameter."}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.li,{children:"Return Value: None"}),"\n",(0,s.jsxs)(n.li,{children:["Exceptions Thrown:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"BluetoothError: Generic error related to Bluetooth connectivity."}),"\n",(0,s.jsx)(n.li,{children:"NetworkError: Error occurs when there's an issue with the network connection."}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.h2,{id:"class-pico",children:"Class Pico"}),"\n",(0,s.jsx)(n.h3,{id:"class-description-1",children:"Class Description"}),"\n",(0,s.jsx)(n.p,{children:"The Pico class represents the data methods the microcontroller contains."}),"\n",(0,s.jsx)(n.h4,{id:"data-fields-1",children:"Data Fields"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"identifier"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Identifier of the Bluetooth device."}),"\n",(0,s.jsx)(n.li,{children:"Type: UUID"}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"dataList"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Hold the data from the sensors in a list"}),"\n",(0,s.jsx)(n.li,{children:"Type: List: [Integer]"}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.h4,{id:"methods-1",children:"Methods"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"sendData(data)"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Purpose: Sends data to the mobile device."}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Pre-conditions: Bluetooth connection is established."}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Post-conditions: Data is sent to the device."}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Parameters:"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"data (List[Integer]): The list of data generated by sensors"}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Return Value: None"}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:"Exceptions Thrown:"}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"BluetoothError: Generic error related to Bluetooth connectivity."}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n",(0,s.jsxs)(n.li,{children:["\n",(0,s.jsx)(n.p,{children:(0,s.jsx)(n.code,{children:"read_from_sensors(ID)"})}),"\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"Purpose: Reads data from sensors connected to the Raspberry Pi Pico."}),"\n",(0,s.jsx)(n.li,{children:"Pre-conditions: Sensors are connected and functioning properly."}),"\n",(0,s.jsx)(n.li,{children:"Post-conditions: Sensor data is retrieved or error is returned."}),"\n",(0,s.jsxs)(n.li,{children:["Parameters:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"ID (int): The ID of the sensor"}),"\n"]}),"\n"]}),"\n",(0,s.jsx)(n.li,{children:"Return Value: None"}),"\n",(0,s.jsxs)(n.li,{children:["Exceptions Thrown:","\n",(0,s.jsxs)(n.ul,{children:["\n",(0,s.jsx)(n.li,{children:"SensorError: Error occurs when there's an issue with reading sensor data."}),"\n"]}),"\n"]}),"\n"]}),"\n"]}),"\n"]})]})}function h(e={}){const{wrapper:n}={...(0,r.a)(),...e.components};return n?(0,s.jsx)(n,{...e,children:(0,s.jsx)(a,{...e})}):a(e)}},11151:(e,n,i)=>{i.d(n,{Z:()=>l,a:()=>o});var s=i(67294);const r={},t=s.createContext(r);function o(e){const n=s.useContext(t);return s.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:o(e.components),s.createElement(t.Provider,{value:n},e.children)}}}]);