#
# Cookbook Name:: sidekiq
# Attrbutes:: default
#

default[:sidekiq] = {
  # Sidekiq will be installed on to application/solo instances,
  # unless a utility name is set, in which case, Sidekiq will
  # only be installed on to a utility instance that matches
  # the name
  :utility_name => 'sidekiq',

  # Number of workers (not threads)
  :workers => 4,

  # Concurrency
  :concurrency => 15,

  # Queues
  :queues => {
    # :queue_name => priority
    :default  => 1,
    :import   => 2,
    :email    => 3,
  },

  # Verbose
  :verbose => false
}
