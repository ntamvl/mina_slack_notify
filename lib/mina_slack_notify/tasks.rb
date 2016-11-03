require "mina/bundler"
require "mina/rails"
require 'json'
require 'httparty'

# Control Tasks
namespace :slack do
  # ## Settings
  # Any and all of these settings can be overriden in your `deploy.rb`.

  # ### slack_api_token
  # Sets the slack api auth token.
  set :slack_api_token, ''
  set :slack_team_domain, ''

  # ### slack_channels
  # Sets the channels where notifications will be sent to.
  set :slack_channels, []

  # ### slack_username
  # Sets the notification 'from' user label
  set :slack_username, 'Mina'

  # slack_author
  # Sets the deployment author name
  set :slack_author, 'Mina'

  # ### slack_link_names
  # Sets the deployment author name
  set :slack_link_names, 1

  # slack_parse
  # Sets the deployment author name
  set :slack_parse, 'full'

  # icon_url
  # URL to an image to use as the icon for this message
  set :slack_icon_url, ''

  # icon_emoji
  # Sets emoji to use as the icon for this message. Overrides `slack_icon_url`
  set :slack_icon_emoji, ':slack:'


  # slack:notify_deploy_started
  desc "Send slack notification about new deploy start"
  task :notify_deploy_started => :environment do
    # queue  %[echo "-----> Sending start notification to Slack"]
    comment %{Sending start notification to Slack}
    text = "[Deploying] #{fetch(:slack_author)} is deploying #{fetch(:application)} on #{fetch(:domain)}...\n"

    slack_channels = fetch(:slack_channels)
    for channel in fetch(:slack_channels)
      send_message(
        channel: channel,
        text:    text
      )
    end
  end

  # slack:notify_deploy_finished
  desc "Send slack notification about deploy finish"
  task :notify_deploy_finished => :environment do
    # queue  %[echo "-----> Sending finish notification to Slack"]
    comment %{Sending finish notification to Slack}

    text  = "#{fetch(:slack_author)} finished deploying #{fetch(:application)}."
    text += " on server #{fetch(:domain)} \n" if fetch(:domain) != nil
    attachments = fetch(:attachments)
    slack_channels = fetch(:slack_channels)

    for channel in slack_channels
      send_message(
        channel:     channel,
        text:        text,
        attachments: attachments
      )
    end
  end

  # slack:notify_deploy_finished
  desc "Send slack notification about deploying"
  task :notify_deploying => :environment do
    # queue  %[echo "-----> Sending finish notification to Slack"]
    comment %{Sending finish notification to Slack}

    # text  = "[auto deployment] *#{slack_author}* finished deploying *#{application}*."
    # text += " on server #{domain} \n" if domain != nil
    git_logs = %x[git log --stat]

    git_logs = %x[git log --pretty=format:"%an (%h) %s" -n 5]
    text = "*#{fetch(:slack_author).delete!("\n")}* deployed #{fetch(:application)} in #{fetch(:server_name)} (#{fetch(:domain)}) \n"
    git_logs.each_line do |line|
      text += "> #{line}"
    end

    attachments = fetch(:attachments)

    slack_channels = fetch(:slack_channels)
    puts "\nslack_channels: #{slack_channels} \n"
    for channel in slack_channels
      send_message(
        channel:     channel,
        text:        text,
        attachments: attachments
      )
    end
  end

  def send_message(params = {})
    slack_url = "https://#{fetch(:slack_team_domain)}.slack.com/services/hooks/slackbot?token=#{fetch(:slack_api_token)}&channel=%23#{params[:channel]}"
    HTTParty.post(slack_url, {body: params[:text]})
  end

end
