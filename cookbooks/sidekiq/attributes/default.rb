#
# Cookbook Name:: sidekiq
# Attrbutes:: default
#

default[:sidekiq] = {
  # Sidekiq will be installed on to application/solo instances,
  # unless a utility name is set, in which case, Sidekiq will
  # only be installed on to a utility instance that matches
  # the name
  :utility_name => 'Utility',

  # Number of workers (not threads)
  :workers => 8,

  # Concurrency
  :concurrency => 20,

  # Queues
  :queues => {
    # :queue_name => priority
    :default  => 1,
    :email    => 2,
    :import   => 3,
  },

  # Verbose
  :verbose => false
}
