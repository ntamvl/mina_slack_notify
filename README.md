# MinaSlackNotify

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mina_slack_notify`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina_slack_notify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina_slack_notify

## Usage example

    require 'mina_slack_notify/tasks'
    ...
    # Required mina_slack_notify options
    ...
    set :application, "app_name"
    ...

    ...
    # example: mina deploy env=developmet
    if !ENV['env'].nil? && ENV['env'] == "production"
      set :domain, '[ip_or_domain_production]'
      set :server_name, "production"
      puts "You are running on producion"
    else
      set :domain, '[ip_or_domain_development]'
      set :server_name, "development"
      puts "You are running on developmet"
    end
    ...
    set :slack_api_token, 'xxxyyyzzz'
    set :slack_channels, ['#general', '@mbajur', '#nerd']
    set :slack_team_domain, 'team_domain'
    set :slack_author, %x[git config user.email]

    task :deploy do
      deploy do
        invoke :'slack:notify_deploy_started'
        ...

        to :launch do
          ...
          invoke :'slack:notify_deploy_finished'
        end
      end
    end

## Available Tasks

* `slack:notify_deploy_started`
* `slack:notify_deploy_finished`

## Available Options

| Option                    | Description                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------ |
| __slack_api_token__       | API auth token.                                                                      |
| __slack_channels__        | Array of channels (or users) where notifications will be sent to.                    |
| slack_username            | Name of bot. <br> _default: Deploy_                                                  |
| slack_author              | Author of a deploy displayed in deploy messages. <br> _default: Someone_             |
| slack_link_names          | Find and link channel names and usernames. <br> _default: 1_                         |
| slack_parse               | Change how messages are treated. [Read more] (https://api.slack.com/docs/formatting) <br> _default: full_ |
| slack_icon_url            | URL to an image to use as the icon for this message <br> _default: nil_ |
| slack_icon_emoji          | emoji to use as the icon for this message. Overrides `slack_icon_url`. <br> _default: :slack:_ |

__* required options__

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ntamvl/mina_slack_notify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

