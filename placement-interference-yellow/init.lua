local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("bot_interfered_placement", {
		Helpers.expectTeam(true), -- yellow
		}, 1, 1))
