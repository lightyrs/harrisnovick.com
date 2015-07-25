# Set the app path for later reference.
app_path    = "/data/apps/harrisnovick.com/current"

# Set the shared path for later reference.
shared_path = "/data/apps/harrisnovick.com/shared"

# The number of worker processes you have here should equal the number of CPU
# cores your server has.
worker_processes 1

# You can listen on a port or a socket. Listening on a socket is good in a
# production environment, but listening on a port can be useful for local
# debugging purposes.
listen "#{shared_path}/app-unicorn.sock", backlog: 64

# For development, you may want to listen on port 3000 so that you can make sure
# your unicorn.rb file is soundly configured.
# listen(3000, backlog: 64) if ENV['RAILS_ENV'] == 'development'

# After the timeout is exhausted, the unicorn worker will be killed and a new
# one brought up in its place. Adjust this to your application's needs.
# If your application needs a longer timeout (for generating reports or the like),
# make sure you set a reasonable timeout here. The default timeout is 60.
# Anything under 3 seconds won't work properly.
timeout 60

# Set the working directory of this unicorn instance.
working_directory app_path

# Set the location of the unicorn pid file.
# This should match what we put in the unicorn init script later.
pid "#{shared_path}/tmp/pids/unicorn.pid"

# You should define your stderr and stdout here. If you don't, stderr defaults
# to /dev/null and you'll lose any error logging when in daemon mode.
stderr_path "#{shared_path}/log/unicorn.stderr.log"
stdout_path "#{shared_path}/log/unicorn.stdout.log"

# Load the app up before forking.
preload_app true

# Garbage collection settings.
GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
check_client_connection false

# If using ActiveRecord, disconnect (from the database) before forking.
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.

  # This allows a new master process to incrementally
  # phase out the old master process with SIGTTOU to avoid a
  # thundering herd (especially in the "preload_app false" case)
  # when doing a transparent upgrade.  The last worker spawned
  # will then kill off the old master process with a SIGQUIT.
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  sleep 1
end

# After forking, restore your ActiveRecord connection.
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end

before_exec do |server|
  gemfile = "#{app_path}/Gemfile"
  if File.exists?(gemfile)
    ENV['BUNDLE_GEMFILE'] = gemfile
  end
end
