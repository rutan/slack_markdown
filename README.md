# SlackMarkdown

SlackMarkdown (https://api.slack.com/docs/formatting) to HTML converter.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_markdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_markdown

## Usage

```ruby
require 'slack_markdown'

processor = SlackMarkdown::Processor.new(
  on_slack_channel_id: -> (uid) {
    # TODO: use Slack API
    return { url: '/general', text: 'general' }
  },
  on_slack_user_id: -> (uid) {
    # TODO: use Slack API
    return { url: '/ru_shalm', text: 'ru_shalm' }
  },
  asset_root: '/',
  original_emoji_set: { ... },
)

processor.call("<@U12345> hello *world*")[:output].to_s
# => "<a href="/ru_shalm">@ru_shalm</a> hello <b>world</b>"
```

## Contributing

1. Fork it ( https://github.com/rutan/slack_markdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
