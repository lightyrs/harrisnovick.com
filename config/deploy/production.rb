role :app,     %w{deploy@45.55.79.177}
role :web,     %w{deploy@45.55.79.177}
role :db,      %w{deploy@45.55.79.177}
role :worker,  %w{deploy@45.55.79.177}

set :stage,       :production
set :rails_env,   :production
set :rack_env,    :production

set :branch,      ENV["BRANCH"] || 'master'

server "45.55.79.177", user: "deploy", roles: %w{app web db worker}
