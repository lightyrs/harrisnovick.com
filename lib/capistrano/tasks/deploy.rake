namespace :deploy do
  task :start do
    on roles(:app) do
      as "root" do
        execute "/etc/init.d/unicorn start"
      end
    end
  end

  task :stop do
    on roles(:app) do
      as "root" do
        execute "/etc/init.d/unicorn stop"
      end
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      as "root" do
        execute "/etc/init.d/unicorn restart"
      end
    end
  end
end
