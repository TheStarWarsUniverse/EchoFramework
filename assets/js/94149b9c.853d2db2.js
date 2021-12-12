"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[707],{61947:function(e){e.exports=JSON.parse('{"functions":[{"name":"CreateController","desc":"Constructs a new controller.\\n```lua\\nlocal EchoController = Echo:CreateController({\\n\\tName = \\"EchoController\\",\\n\\tServer = {}\\n})\\n\\nfunction EchoController.Server:Example(...)\\n\\tprint(\\"Example\\")\\nend\\n\\nfunction EchoController:EchoStart()\\n\\tprint(\\"Echo Start\\")\\nend\\n\\nfunction EchoController:EchoInit()\\n\\tprint(\\"Echo Init\\")\\nend\\n\\nreturn EchoController\\n```","params":[{"name":"ControllerInfo","desc":"","lua_type":"ControllerDefine"}],"returns":[{"desc":"","lua_type":"Controller"}],"function_type":"method","source":{"line":77,"path":"src/EchoInstaller/EchoClient/Functions/Controllers.lua"}},{"name":"GetController","desc":"Gets the controller by name. Throws an error if the controller is not found.","params":[{"name":"ControllerName","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Controller?"}],"function_type":"method","source":{"line":109,"path":"src/EchoInstaller/EchoClient/Functions/Controllers.lua"}},{"name":"Connect","desc":"Connects a function to the signal, which will be called anytime the signal is fired.","params":[{"name":"Name","desc":"","lua_type":"string"},{"name":"Function","desc":"","lua_type":"function"}],"returns":[],"function_type":"method","source":{"line":22,"path":"src/EchoInstaller/EchoClient/Functions/Network.lua"}},{"name":"Disconnect","desc":"Connects a function to the signal, which will be called anytime the signal is fired.","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[],"function_type":"method","source":{"line":33,"path":"src/EchoInstaller/EchoClient/Functions/Network.lua"}},{"name":"FireServer","desc":"Fires the signal at the server with any arguments.","params":[{"name":"Function","desc":"","lua_type":"string"},{"name":"[any]","desc":"","lua_type":"any?"}],"returns":[],"function_type":"method","source":{"line":43,"path":"src/EchoInstaller/EchoClient/Functions/Network.lua"}},{"name":"InvokeServer","desc":"Invoke the signal at the server with any arguments and expected return from the server.","params":[{"name":"Function","desc":"","lua_type":"string"},{"name":"[any]","desc":"","lua_type":"any?"}],"returns":[],"function_type":"method","source":{"line":53,"path":"src/EchoInstaller/EchoClient/Functions/Network.lua"}},{"name":"GetWallySharedPackages","desc":"Get a shared wally package from client.","params":[{"name":"PackageName","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Wally Package"}],"function_type":"method","source":{"line":17,"path":"src/EchoInstaller/EchoClient/Functions/Wally.lua"}}],"properties":[],"types":[{"name":"ControllerDefine","desc":"Used to define a controller while creating it in \\"CreateController\\"","fields":[{"name":"Name","lua_type":"string","desc":""},{"name":"Server","lua_type":"table?","desc":""},{"name":"[any]","lua_type":"any","desc":""}],"source":{"line":15,"path":"src/EchoInstaller/EchoClient/Functions/Controllers.lua"}},{"name":"Controller","desc":"","fields":[{"name":"Name","lua_type":"string","desc":""},{"name":"Server","lua_type":"ControllerServer","desc":""},{"name":"[any]","lua_type":"any","desc":""}],"source":{"line":28,"path":"src/EchoInstaller/EchoClient/Functions/Controllers.lua"}},{"name":"ControllerServer","desc":"","fields":[{"name":"Client","lua_type":"Controller","desc":""},{"name":"[any]","lua_type":"any","desc":""}],"source":{"line":40,"path":"src/EchoInstaller/EchoClient/Functions/Controllers.lua"}}],"name":"EchoClient","desc":"The client script of Echo framework.","realm":["Client"],"source":{"line":10,"path":"src/EchoInstaller/EchoClient/init.lua"}}')}}]);