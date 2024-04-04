"use strict";(self.webpackChunkcreate_project_docs=self.webpackChunkcreate_project_docs||[]).push([[284],{98938:(e,n,i)=>{i.r(n),i.d(n,{assets:()=>o,contentTitle:()=>c,default:()=>p,frontMatter:()=>r,metadata:()=>a,toc:()=>d});var t=i(85893),s=i(11151);const r={},c="PetStore",a={id:"api-specification/design-api/Pet-store",title:"Pet-store",description:"Structure",source:"@site/docs/api-specification/design-api/Pet-store.md",sourceDirName:"api-specification/design-api",slug:"/api-specification/design-api/Pet-store",permalink:"/project-smartweights/docs/api-specification/design-api/Pet-store",draft:!1,unlisted:!1,editUrl:"https://github.com/Capstone-Projects-2024-Spring/project-smartweights/edit/main/documentation/docs/api-specification/design-api/Pet-store.md",tags:[],version:"current",lastUpdatedBy:"Daniel Eap",frontMatter:{},sidebar:"docsSidebar",previous:{title:"Pet-page",permalink:"/project-smartweights/docs/api-specification/design-api/Pet-page"},next:{title:"PostWorkout",permalink:"/project-smartweights/docs/api-specification/design-api/PostWorkout"}},o={},d=[];function l(e){const n={code:"code",h1:"h1",hr:"hr",p:"p",pre:"pre",strong:"strong",...(0,s.a)(),...e.components};return(0,t.jsxs)(t.Fragment,{children:[(0,t.jsx)(n.p,{children:(0,t.jsx)(n.code,{children:"Structure"})}),"\n",(0,t.jsx)(n.h1,{id:"petstore",children:"PetStore"}),"\n",(0,t.jsx)(n.p,{children:"Display view for the Pet Store depending on available items and prices."}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"struct PetStore\n"})}),"\n",(0,t.jsx)(n.h1,{id:"topics",children:"Topics"}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.strong,{children:"Initializers"})}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"init()\n"})}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.strong,{children:"Instance Properties"})}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"var body: some View\n\nlet categories: [String]\n"})}),"\n",(0,t.jsx)(n.hr,{}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.code,{children:"Structure"})}),"\n",(0,t.jsx)(n.h1,{id:"sellingitem",children:"SellingItem"}),"\n",(0,t.jsx)(n.p,{children:"SellingItem struct that contains essential item attributes."}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"struct SellingItem\n"})}),"\n",(0,t.jsx)(n.h1,{id:"topics-1",children:"Topics"}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.strong,{children:"Initializers"})}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"init(id: Int, name: String, category: String, price: String, image: Image, description: String)\n"})}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.strong,{children:"Instance Properties"})}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"var category: String\n\nvar description: String\n\nvar id: Int\n\nvar image: Image\n\nvar name: String\n\nvar price: String\n"})}),"\n",(0,t.jsx)(n.hr,{}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.code,{children:"Structure"})}),"\n",(0,t.jsx)(n.h1,{id:"itemdetailview",children:"ItemDetailView"}),"\n",(0,t.jsx)(n.p,{children:"Display view for previewing and purchasing and item."}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"struct ItemDetailView\n"})}),"\n",(0,t.jsx)(n.h1,{id:"topics-2",children:"Topics"}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.strong,{children:"Initializers"})}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"init(item: SellingItem, userCur: Int)\n"})}),"\n",(0,t.jsx)(n.p,{children:(0,t.jsx)(n.strong,{children:"Instance Properties"})}),"\n",(0,t.jsx)(n.pre,{children:(0,t.jsx)(n.code,{className:"language-swift",children:"var body: some View\n\nlet item: SellingItem\n\nlet userCur: Int\n"})})]})}function p(e={}){const{wrapper:n}={...(0,s.a)(),...e.components};return n?(0,t.jsx)(n,{...e,children:(0,t.jsx)(l,{...e})}):l(e)}},11151:(e,n,i)=>{i.d(n,{Z:()=>a,a:()=>c});var t=i(67294);const s={},r=t.createContext(s);function c(e){const n=t.useContext(r);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function a(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:c(e.components),t.createElement(r.Provider,{value:n},e.children)}}}]);