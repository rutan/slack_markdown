# encoding: utf-8
require 'spec_helper'

describe SlackMarkdown::Processor do
  subject do
    context = {
      asset_root: '/assets',
      original_emoji_set: {
        'ru_shalm' => 'http://toripota.com/img/ru_shalm.png',
      },
      on_slack_user_id: lambda do |uid|
        { text: 'ru_shalm', url: '/@ru_shalm' } if uid == 'U12345'
      end,
      on_slack_channel_id: lambda do |uid|
        { text: 'ru_shalm', url: 'http://toripota.com' } if uid == 'U12345'
      end,
      cushion_link: 'http://localhost/?url=',
    }
    processor = SlackMarkdown::Processor.new(context)
    processor.call(text)[:output].to_s
  end

  let :text do
    <<EOS
<@U12345> <@U23456> *SlackMarkdown* is `text formatter` ~package~ _gem_ .
> :ru_shalm: is <http://toripota.com/img/ru_shalm.png>
EOS
  end

  it do
    should eq "<a href=\"/@ru_shalm\" class=\"mention\">@ru_shalm</a> @U23456 <b>SlackMarkdown</b> is <code>text formatter</code> <strike>package</strike> <i>gem</i> .<br><blockquote>
<img class=\"emoji\" title=\":ru_shalm:\" alt=\":ru_shalm:\" src=\"http://toripota.com/img/ru_shalm.png\" height=\"20\" width=\"20\" align=\"absmiddle\"> is <a href=\"http://localhost/?url=http%3A%2F%2Ftoripota.com%2Fimg%2Fru_shalm.png\" class=\"link\">http://toripota.com/img/ru_shalm.png</a><br>
</blockquote>"
  end
end
