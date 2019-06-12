local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("bot_too_fast_in_stop", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
