# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Better deploy log output
require 'airbrussh/capistrano'

# Include capistrano plugin tasks
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/sidekiq'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/git-submodule-strategy'
require 'whenever/capistrano'

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
