require 'json'
require 'httparty'

# ## Settings
# Any and all of these settings can be overriden in your `deploy.rb`.

# ### slack_api_token
# Sets the slack api auth token.
set_default :slack_api_token, ''
set_default :slack_team_domain, ''

# ### slack_channels
# Sets the channels where notifications will be sent to.
set_default :slack_channels, []

# ### slack_username
# Sets the notification 'from' user label
set_default :slack_username, 'Mina'

# slack_author
# Sets the deployment author name
set_default :slack_author, 'Mina'

# ### slack_link_names
# Sets the deployment author name
set_default :slack_link_names, 1

# slack_parse
# Sets the deployment author name
set_default :slack_parse, 'full'

# icon_url
# URL to an image to use as the icon for this message
set_default :slack_icon_url, ''

# icon_emoji
# Sets emoji to use as the icon for this message. Overrides `slack_icon_url`
set_default :slack_icon_emoji, ':slack:'

# Control Tasks
namespace :slack do

  # slack:notify_deploy_started
  desc "Send slack notification about new deploy start"
  task :notify_deploy_started => :environment do
    queue  %[echo "-----> Sending start notification to Slack"]
    text = "[Deploying] #{slack_author} is deploying #{application} on #{domain}..."

    for channel in slack_channels
      send_message(
        channel: channel,
        text:    text
      )
    end
  end

  # slack:notify_deploy_finished
  desc "Send slack notification about deploy finish"
  task :notify_deploy_finished => :environment do
    queue  %[echo "-----> Sending finish notification to Slack"]

    text  = "#{slack_author} finished deploying #{application}."
    text += " on server #{domain}" if domain != nil

    for channel in slack_channels
      send_message(
        channel:     channel,
        text:        text,
        attachments: attachments
      )
    end
  end

  def send_message(params = {})
    slack_url = "https://#{slack_team_domain}.slack.com/services/hooks/slackbot?token=#{slack_api_token}&channel=%23#{params[:channel]}"
    HTTParty.post(slack_url, {body: params[:text]})
  end

end
