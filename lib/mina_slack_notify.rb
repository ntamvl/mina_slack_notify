require "mina_slack_notify/version"
require "mina/plugin"

if defined?(Mina) && self.respond_to?(:mina_cleanup!)
  extend Mina::Hooks::Plugin
end

module MinaSlackNotify
  # Your code goes here...
end
