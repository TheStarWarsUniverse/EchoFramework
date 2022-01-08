# Controllers

## Controllers Defined

Controllers are singleton provider objects that serve a specific purpose on the client. For instance, a game might have a CameraController, which manages a custom in-game camera for the player.

A controller is essentially the client-side equivalent of a service on the server.

## Creating Controllers

In its simplest form, a controller can be created like so:

```lua
local CameraController = Echo:CreateController({
	Name = "CameraController"
})

function CameraController:EchoInit()

end

function CameraController:EchoStart()

end

return CameraController