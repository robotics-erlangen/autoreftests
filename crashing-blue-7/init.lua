local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("bot_crash_unique", {
		Helpers.expectTeam(false), -- blue
		Helpers.expectBotId(7, "violator"),
		Helpers.expectBotId(11, "victim")
		}, 1, 1))
