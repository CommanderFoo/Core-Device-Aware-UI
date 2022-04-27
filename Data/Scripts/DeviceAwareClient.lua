local DEVICE_AWARE_SETTINGS = require(script:GetCustomProperty("DeviceAwareSettings"))

local function OnInputChanged(player, inputType)
	for index, row in ipairs(DEVICE_AWARE_SETTINGS) do
		local visibility = Visibility.FORCE_OFF
		local offset = Vector2.New()

		if row.mobile and inputType == InputType.TOUCH then
			visibility = Visibility.INHERIT
			offset = row.mobileOffset
		elseif row.pc and inputType == InputType.KEYBOARD_AND_MOUSE then
			visibility = Visibility.INHERIT
			offset = row.pcOffset
		end

		row.ui:GetObject().visibility = visibility

		if row.useOffset then
			row.ui:GetObject().x = offset.x
			row.ui:GetObject().y = offset.y
		end
	end
end

Input.inputTypeChangedEvent:Connect(OnInputChanged)

OnInputChanged(Game.GetLocalPlayer(), Input.GetCurrentInputType())