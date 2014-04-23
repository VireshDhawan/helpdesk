# Supported options: :resque, :sidekiq, :delayed_job, :queue_classic, :torquebox
Devise::Async.backend = :sidekiq
Devise::Async.queue = :helpdesk_devise_queue