### Notes from redesign at home

I have used the wikipedia page section on [Game score](https://en.wikipedia.org/wiki/Tennis_scoring_system#Game_score) to further understand the scoring in a single tennis game

## Actions

1. Commit the state I left the interview as the initial git commit
2. In the `#initalize` spec I was incorrectly calling `game.score` which is not correct as it is not part of the method. `#score` as defined in the requirements section is its own method, so cannot be called directly without adding it to initialize method and an accessor for it. Based on this I refactored the spec 