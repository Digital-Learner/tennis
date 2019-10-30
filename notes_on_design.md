### Notes from redesign at home

I have used the wikipedia page section on [Game score](https://en.wikipedia.org/wiki/Tennis_scoring_system#Game_score) to further understand the scoring in a single tennis game

## Actions

1. Commit the state I left the interview as the initial git commit
2. In the `#initalize` spec I was incorrectly calling `game.score` which is not correct as it is not part of the method. `#score` as defined in the requirements section is its own method, so cannot be called directly without adding it to initialize method and an accessor for it. Based on this I refactored the spec
3. Basically went through each of the described scenarios and made them pass
4. Some refactoring along the way
5. Removal of Gem related files e.g. *.gemspec
6. Added rubocop and rubocop-rspec for linting and setup of basic configuration overrides
7. Red/Green/Refactor with combination of TDD / BDD


## Docker image details

 - build from ruby 2.6 alpine image (to keep it small)
 - `docker build -t game-of-tennis:0.1.0 .` to build the `game-of-tennis` docker image
 - (A)`docker run -it --rm -v $PWD:/usr/src/app game-of-tennis:0.1.0 sh` to run the container
 - once in container will need to initially run `bundle install` to install the gems
 - then run specs with `bundle exec rspec` (within container)
 - run rubocop with `rubocop lib/game.rb` and `spec/game_spec.rb` for linting

 OR

 - (B) `docker run -it --rm -v $PWD:/usr/src/app game-of-tennis:0.1.0 bundle exec rspec` to run without doing (A)
 
 - run rubocop with ``docker run -it --rm -v $PWD:/usr/src/app game-of-tennis:0.1.0 bundle exec rubocop <filename>` for linting without doing (A)