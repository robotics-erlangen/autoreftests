require "amun"

local AutorefTestHelpers = {}

local function failTestWithMessage(message)
	amun.log("os.exit(1)")
	error(message)
end

local function splitString(inputstr, sep)
	local t = {}
	-- replace with some character that will never be in the input string
	subbed = string.gsub(inputstr, sep, "§")
	for str in string.gmatch(subbed, "([^§]+)") do
		table.insert(t, str)
	end
	return t
end

function AutorefTestHelpers.debugTreeToObject(debugValues, prefix)
	local result = {}
	local hasParts = false
	for _, value in ipairs(debugValues) do
		local split = splitString(value.key, prefix)
		if #split == 2 then
			local objectParts = splitString(split[2], "/")
			local objectToWriteTo = result
			for i = 1,#objectParts-1 do
				if not objectToWriteTo[objectParts[i]] or type(objectToWriteTo[objectParts[i]]) ~= "table" then
					objectToWriteTo[objectParts[i]] = {}
				end
				objectToWriteTo = objectToWriteTo[objectParts[i]]
			end
			if value.float_value then
				objectToWriteTo[objectParts[#objectParts]] = value.float_value
			elseif value.bool_value then
				objectToWriteTo[objectParts[#objectParts]] = value.bool_value
			elseif value.string_value then
				objectToWriteTo[objectParts[#objectParts]] = value.string_value
			else
				objectToWriteTo[objectParts[#objectParts]] = nil
			end

			hasParts = true
		end
	end
	if not hasParts then
		return nil
	end
	return result
end

function AutorefTestHelpers.createReplayTestRunner(testName, handlerFunctions)
	local function testStatus(status)
		for _, d in ipairs(status.debug) do
			local eventCounter = 1
			while true do
				-- omit GAME_ from string so there is some first part of the string if it is toplevel
				local object = AutorefTestHelpers.debugTreeToObject(d.value, "CONTROLLER_EVENTS/"..eventCounter.."/")
				if object then
					handlerFunctions[1](object)
				else
					break
				end
				eventCounter = eventCounter + 1
			end
		end
	end

	local function runFrame()
		local status = amun.getTestStatus()
		--amun.log("Run frame: "..tostring(status.time))
		if status.time then
			testStatus(status)
		else
			handlerFunctions[2]()
		end
	end
	return {name = testName, entrypoints = {main = runFrame}}
end

-- the event can be triggered between timesMin and timesMax often (both inclusive)
-- if not given, it defaults to between one and infinite times
function AutorefTestHelpers.expectEventMultiple(eventName, ruleParts, timesMin, timesMax)
	if not timesMin then
		timesMin = 1
	end
	if not timesMax then
		timesMax = math.huge
	end
	local eventCounter = 0
	local function eventHandler(event)
		if event[eventName] then
			for _, rule in ipairs(ruleParts) do
				rule(event[eventName])
			end
			eventCounter = eventCounter + 1
			if eventCounter > timesMax then
				failTestWithMessage("Event "..eventName.." occurred more than "..timesMax.." times")
			end
		else
			for name, _ in pairs(event) do
				if name ~= "type" then
					failTestWithMessage("Did not expect event: " .. name)
				end
			end
		end
	end
	local function finalJudgementHandler()
		if eventCounter < timesMin then
			if eventCounter == 0 then
				failTestWithMessage("Expected event "..eventName..", which did not occurr")
			else
				failTestWithMessage("Event "..eventName.." did not occurr often enough "..tostring(eventCounter))
			end
		end
	end
	return {eventHandler, finalJudgementHandler}
end

-- expect the specified event once, then anything else can happen
function AutorefTestHelpers.expectFirstEvent(eventName, ruleParts)
	local eventHappened = false
	local function eventHandler(event)
		if eventHappened then
		return
		end
		if event[eventName] then
			for _, rule in ipairs(ruleParts) do
				rule(event[eventName])
			end
			eventHappened = true
		else
			for name, _ in pairs(event) do
				if name ~= "type" then
					failTestWithMessage("Did not expect event: " .. name)
				end
			end
		end
	end
	local function finalJudgementHandler()
		if not eventHappened then
			failTestWithMessage("Expected event "..eventName..", which did not occurr")
		end
	end
	return {eventHandler, finalJudgementHandler}
end

function AutorefTestHelpers.expectTeam(teamIsYellow, indexString)
	if not indexString then
		indexString = "by_team"
	end
	local function eventHandler(event)
		if not event[indexString] then
			failTestWithMessage("Expected team information in event!")
		end
		if (teamIsYellow and event[indexString] ~= "YELLOW") or
				((not teamIsYellow) and event[indexString] ~= "BLUE") then
			failTestWithMessage("Wrong team in event, expected "..(teamIsYellow and "YELLOW" or "BLUE").." got "..event[indexString])
		end
	end
	return eventHandler
end

function AutorefTestHelpers.expectBotId(id, indexString)
	if not indexString then
		indexString = "by_bot"
	end
	local function eventHandler(event)
		if not event[indexString] then
			failTestWithMessage("Expected bot id information in event!")
		end
		if event[indexString] ~= id then
			failTestWithMessage("Wrong bot id in event, expected "..id.." got "..event[indexString])
		end
	end
	return eventHandler
end

function AutorefTestHelpers.expectRoughLocation(x, y, radius, indexString)
	if not radius then
		radius = 0.3
	end
	if not indexString then
		indexString = "location"
	end
	local function eventHandler(event)
		if not event[indexString] or not event[indexString].x or not event[indexString].y then
			failTestWithMessage("Expected location information in event!")
		end
		local xDiff = x - event[indexString].x
		local yDiff = y - event[indexString].y
		local distanceSq = xDiff * xDiff + yDiff * yDiff
		if distanceSq > radius * radius then
			failTestWithMessage("Event in wront location, expected around ("..x..", "..y.."), got ("..event[indexString].x..", "..event[indexString].y..")")
		end
	end
	return eventHandler
end

return AutorefTestHelpers
