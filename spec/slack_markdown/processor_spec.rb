# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Processor do
  subject do
    context = {
      asset_root: '/assets',
      original_emoji_set: {
        'ru_shalm' => 'http://toripota.com/img/ru_shalm.png'
      },
      on_slack_user_id: lambda do |uid|
        { text: 'ru_shalm', url: '/@ru_shalm' } if uid == 'U12345'
      end,
      on_slack_channel_id: lambda do |uid|
        { text: 'ru_shalm', url: 'http://toripota.com' } if uid == 'C01S1JQMYKV'
      end,
      cushion_link: 'http://localhost/?url='
    }
    processor = SlackMarkdown::Processor.new(context)
    processor.call(text)[:output].to_s
  end

  let :text do
    <<~EOS
      <@U12345> <@U23456> <#C01S1JQMYKV> *SlackMarkdown* is `text formatter` ~package~ _gem_ .
      > :ru_shalm: is <http://toripota.com/img/ru_shalm.png>
      <@U12345|dont_override_me> <@U23456|override_me> <#C01S1JQMYKV|dont_override_me> <#C12345|override_me>
    EOS
  end

  it do
    should eq "<a href=\"/@ru_shalm\" class=\"mention\">@ru_shalm</a> @U23456 <a href=\"http://localhost/?url=http%3A%2F%2Ftoripota.com\" class=\"channel\">#ru_shalm</a> <b>SlackMarkdown</b> is <code>text formatter</code> <strike>package</strike> <i>gem</i> .<br><blockquote>
<img class=\"emoji\" title=\":ru_shalm:\" alt=\":ru_shalm:\" src=\"http://toripota.com/img/ru_shalm.png\" height=\"20\" width=\"20\" align=\"absmiddle\"> is <a href=\"http://localhost/?url=http%3A%2F%2Ftoripota.com%2Fimg%2Fru_shalm.png\" class=\"link\">http://toripota.com/img/ru_shalm.png</a><br>
</blockquote><a href=\"/@ru_shalm\" class=\"mention\">@ru_shalm</a> override_me <a href=\"http://localhost/?url=http%3A%2F%2Ftoripota.com\" class=\"channel\">#ru_shalm</a> <a href=\"#C12345\" class=\"channel\">override_me</a><br>"
  end
end
