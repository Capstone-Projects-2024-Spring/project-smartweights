"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[3783],{93704:(e,r,n)=>{n.r(r),n.d(r,{assets:()=>c,contentTitle:()=>i,default:()=>p,frontMatter:()=>t,metadata:()=>a,toc:()=>d});var s=n(85893),o=n(3905);const t={sidebar_position:1},i="Manage Docs Versions",a={id:"tutorial-extras/manage-docs-versions",title:"Manage Docs Versions",description:"Docusaurus can manage multiple versions of your docs.",source:"@site/tutorial/tutorial-extras/manage-docs-versions.md",sourceDirName:"tutorial-extras",slug:"/tutorial-extras/manage-docs-versions",permalink:"/project-smartweights/tutorial/tutorial-extras/manage-docs-versions",draft:!1,unlisted:!1,tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"docsSidebar",previous:{title:"Tutorial - Extras",permalink:"/project-smartweights/tutorial/category/tutorial---extras"},next:{title:"Translate your site",permalink:"/project-smartweights/tutorial/tutorial-extras/translate-your-site"}},c={},d=[{value:"Create a docs version",id:"create-a-docs-version",level:2},{value:"Add a Version Dropdown",id:"add-a-version-dropdown",level:2},{value:"Update an existing version",id:"update-an-existing-version",level:2}];function l(e){const r={code:"code",h1:"h1",h2:"h2",img:"img",li:"li",p:"p",pre:"pre",strong:"strong",ul:"ul",...(0,o.ah)(),...e.components};return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(r.h1,{id:"manage-docs-versions",children:"Manage Docs Versions"}),"\n",(0,s.jsx)(r.p,{children:"Docusaurus can manage multiple versions of your docs."}),"\n",(0,s.jsx)(r.h2,{id:"create-a-docs-version",children:"Create a docs version"}),"\n",(0,s.jsx)(r.p,{children:"Release a version 1.0 of your project:"}),"\n",(0,s.jsx)(r.pre,{children:(0,s.jsx)(r.code,{className:"language-bash",children:"npm run docusaurus docs:version 1.0\n"})}),"\n",(0,s.jsxs)(r.p,{children:["The ",(0,s.jsx)(r.code,{children:"docs"})," folder is copied into ",(0,s.jsx)(r.code,{children:"versioned_docs/version-1.0"})," and ",(0,s.jsx)(r.code,{children:"versions.json"})," is created."]}),"\n",(0,s.jsx)(r.p,{children:"Your docs now have 2 versions:"}),"\n",(0,s.jsxs)(r.ul,{children:["\n",(0,s.jsxs)(r.li,{children:[(0,s.jsx)(r.code,{children:"1.0"})," at ",(0,s.jsx)(r.code,{children:"http://localhost:3000/docs/"})," for the version 1.0 docs"]}),"\n",(0,s.jsxs)(r.li,{children:[(0,s.jsx)(r.code,{children:"current"})," at ",(0,s.jsx)(r.code,{children:"http://localhost:3000/docs/next/"})," for the ",(0,s.jsx)(r.strong,{children:"upcoming, unreleased docs"})]}),"\n"]}),"\n",(0,s.jsx)(r.h2,{id:"add-a-version-dropdown",children:"Add a Version Dropdown"}),"\n",(0,s.jsx)(r.p,{children:"To navigate seamlessly across versions, add a version dropdown."}),"\n",(0,s.jsxs)(r.p,{children:["Modify the ",(0,s.jsx)(r.code,{children:"docusaurus.config.js"})," file:"]}),"\n",(0,s.jsx)(r.pre,{children:(0,s.jsx)(r.code,{className:"language-js",metastring:'title="docusaurus.config.js"',children:"module.exports = {\n  themeConfig: {\n    navbar: {\n      items: [\n        // highlight-start\n        {\n          type: 'docsVersionDropdown',\n        },\n        // highlight-end\n      ],\n    },\n  },\n};\n"})}),"\n",(0,s.jsx)(r.p,{children:"The docs version dropdown appears in your navbar:"}),"\n",(0,s.jsx)(r.p,{children:(0,s.jsx)(r.img,{alt:"Docs Version Dropdown",src:n(77478).Z+"",width:"370",height:"302"})}),"\n",(0,s.jsx)(r.h2,{id:"update-an-existing-version",children:"Update an existing version"}),"\n",(0,s.jsx)(r.p,{children:"It is possible to edit versioned docs in their respective folder:"}),"\n",(0,s.jsxs)(r.ul,{children:["\n",(0,s.jsxs)(r.li,{children:[(0,s.jsx)(r.code,{children:"versioned_docs/version-1.0/hello.md"})," updates ",(0,s.jsx)(r.code,{children:"http://localhost:3000/docs/hello"})]}),"\n",(0,s.jsxs)(r.li,{children:[(0,s.jsx)(r.code,{children:"docs/hello.md"})," updates ",(0,s.jsx)(r.code,{children:"http://localhost:3000/docs/next/hello"})]}),"\n"]})]})}function p(e={}){const{wrapper:r}={...(0,o.ah)(),...e.components};return r?(0,s.jsx)(r,{...e,children:(0,s.jsx)(l,{...e})}):l(e)}},3905:(e,r,n)=>{n.d(r,{ah:()=>d});var s=n(67294);function o(e,r,n){return r in e?Object.defineProperty(e,r,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[r]=n,e}function t(e,r){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var s=Object.getOwnPropertySymbols(e);r&&(s=s.filter((function(r){return Object.getOwnPropertyDescriptor(e,r).enumerable}))),n.push.apply(n,s)}return n}function i(e){for(var r=1;r<arguments.length;r++){var n=null!=arguments[r]?arguments[r]:{};r%2?t(Object(n),!0).forEach((function(r){o(e,r,n[r])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):t(Object(n)).forEach((function(r){Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(n,r))}))}return e}function a(e,r){if(null==e)return{};var n,s,o=function(e,r){if(null==e)return{};var n,s,o={},t=Object.keys(e);for(s=0;s<t.length;s++)n=t[s],r.indexOf(n)>=0||(o[n]=e[n]);return o}(e,r);if(Object.getOwnPropertySymbols){var t=Object.getOwnPropertySymbols(e);for(s=0;s<t.length;s++)n=t[s],r.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var c=s.createContext({}),d=function(e){var r=s.useContext(c),n=r;return e&&(n="function"==typeof e?e(r):i(i({},r),e)),n},l={inlineCode:"code",wrapper:function(e){var r=e.children;return s.createElement(s.Fragment,{},r)}},p=s.forwardRef((function(e,r){var n=e.components,o=e.mdxType,t=e.originalType,c=e.parentName,p=a(e,["components","mdxType","originalType","parentName"]),u=d(n),h=o,j=u["".concat(c,".").concat(h)]||u[h]||l[h]||t;return n?s.createElement(j,i(i({ref:r},p),{},{components:n})):s.createElement(j,i({ref:r},p))}));p.displayName="MDXCreateElement"},77478:(e,r,n)=>{n.d(r,{Z:()=>s});const s=n.p+"assets/images/docsVersionDropdown-35e13cbe46c9923327f30a76a90bff3b.png"}}]);