local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("bot_crash_unique", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
