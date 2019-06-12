local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("bot_kicked_ball_too_fast", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
