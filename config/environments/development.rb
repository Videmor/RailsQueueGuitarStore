GuitarStore::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers.
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models.
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL).
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Do not compress assets.
  config.assets.compress = false

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true


  class GuitarStore::AwesomeQueue

    def initialize
      @queue = []
    end

    def push(job)
      write_to_file(job)
    end

    def pop
      if job = read_from_file
        job
      else
        Struct.new(:run).new(true)
      end
    end
    
    private

      JOBS_FILE = '.jobs'

      def write_to_file(job)
        File.open(JOBS_FILE,'w') do |file|
          Marshal.dump(job, file)
        end        
      end

      def read_from_file
        begin
          File.open(JOBS_FILE, 'r') do |file|
            Marshal.load(file)
          end
        rescue EOFError
        ensure
          clear_file
        end
      end

      def clear_file
        File.truncate(JOBS_FILE, 0)
      end
  end

  # In development, use an in-memory queue for queueing.
  config.queue = GuitarStore::AwesomeQueue

end
