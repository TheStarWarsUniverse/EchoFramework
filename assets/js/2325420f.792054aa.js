"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[732],{3905:function(e,r,n){n.d(r,{Zo:function(){return u},kt:function(){return m}});var t=n(67294);function o(e,r,n){return r in e?Object.defineProperty(e,r,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[r]=n,e}function l(e,r){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var t=Object.getOwnPropertySymbols(e);r&&(t=t.filter((function(r){return Object.getOwnPropertyDescriptor(e,r).enumerable}))),n.push.apply(n,t)}return n}function a(e){for(var r=1;r<arguments.length;r++){var n=null!=arguments[r]?arguments[r]:{};r%2?l(Object(n),!0).forEach((function(r){o(e,r,n[r])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):l(Object(n)).forEach((function(r){Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(n,r))}))}return e}function c(e,r){if(null==e)return{};var n,t,o=function(e,r){if(null==e)return{};var n,t,o={},l=Object.keys(e);for(t=0;t<l.length;t++)n=l[t],r.indexOf(n)>=0||(o[n]=e[n]);return o}(e,r);if(Object.getOwnPropertySymbols){var l=Object.getOwnPropertySymbols(e);for(t=0;t<l.length;t++)n=l[t],r.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var i=t.createContext({}),s=function(e){var r=t.useContext(i),n=r;return e&&(n="function"==typeof e?e(r):a(a({},r),e)),n},u=function(e){var r=s(e.components);return t.createElement(i.Provider,{value:r},e.children)},p={inlineCode:"code",wrapper:function(e){var r=e.children;return t.createElement(t.Fragment,{},r)}},f=t.forwardRef((function(e,r){var n=e.components,o=e.mdxType,l=e.originalType,i=e.parentName,u=c(e,["components","mdxType","originalType","parentName"]),f=s(n),m=o,d=f["".concat(i,".").concat(m)]||f[m]||p[m]||l;return n?t.createElement(d,a(a({ref:r},u),{},{components:n})):t.createElement(d,a({ref:r},u))}));function m(e,r){var n=arguments,o=r&&r.mdxType;if("string"==typeof e||o){var l=n.length,a=new Array(l);a[0]=f;var c={};for(var i in r)hasOwnProperty.call(r,i)&&(c[i]=r[i]);c.originalType=e,c.mdxType="string"==typeof e?e:o,a[1]=c;for(var s=2;s<l;s++)a[s]=n[s];return t.createElement.apply(null,a)}return t.createElement.apply(null,n)}f.displayName="MDXCreateElement"},26683:function(e,r,n){n.r(r),n.d(r,{frontMatter:function(){return c},contentTitle:function(){return i},metadata:function(){return s},toc:function(){return u},default:function(){return f}});var t=n(87462),o=n(63366),l=(n(67294),n(3905)),a=["components"],c={},i="Controllers",s={unversionedId:"Controllers",id:"Controllers",isDocsHomePage:!1,title:"Controllers",description:"Controllers Defined",source:"@site/docs/Controllers.md",sourceDirName:".",slug:"/Controllers",permalink:"/EchoFramework/docs/Controllers",editUrl:"https://github.com/TheStarWarsUniverse/EchoFramework/edit/master/docs/Controllers.md",tags:[],version:"current",frontMatter:{},sidebar:"defaultSidebar",previous:{title:"Services",permalink:"/EchoFramework/docs/Services"}},u=[{value:"Controllers Defined",id:"controllers-defined",children:[]},{value:"Creating Controllers",id:"creating-controllers",children:[]}],p={toc:u};function f(e){var r=e.components,n=(0,o.Z)(e,a);return(0,l.kt)("wrapper",(0,t.Z)({},p,n,{components:r,mdxType:"MDXLayout"}),(0,l.kt)("h1",{id:"controllers"},"Controllers"),(0,l.kt)("h2",{id:"controllers-defined"},"Controllers Defined"),(0,l.kt)("p",null,"Controllers are singleton provider objects that serve a specific purpose on the client. For instance, a game might have a CameraController, which manages a custom in-game camera for the player."),(0,l.kt)("p",null,"A controller is essentially the client-side equivalent of a service on the server."),(0,l.kt)("h2",{id:"creating-controllers"},"Creating Controllers"),(0,l.kt)("p",null,"In its simplest form, a controller can be created like so:"),(0,l.kt)("pre",null,(0,l.kt)("code",{parentName:"pre",className:"language-lua"},'local CameraController = Echo:CreateController({\n    Name = "CameraController"\n})\n\nfunction CameraController:EchoInit()\n\nend\n\nfunction CameraController:EchoStart()\n\nend\n\nreturn CameraController\n')))}f.isMDXComponent=!0}}]);