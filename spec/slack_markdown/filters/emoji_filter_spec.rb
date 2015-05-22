# encoding: utf-8
require 'spec_helper'

describe SlackMarkdown::Filters::EmojiFilter do
  subject do
    context = {
      asset_root: "/assets",
      original_emoji_set: {
        'ru_shalm' => 'http://toripota.com/img/ru_shalm.png'
      }
    }
    filter = SlackMarkdown::Filters::EmojiFilter.new(text, context)
    filter.call.to_s
  end

  context 'Hello :smile:' do
    let(:text) { 'Hello :smile:' }
    it { should eq 'Hello <img class="emoji" title=":smile:" alt=":smile:" src="/assets/emoji/unicode/1f604.png" height="20" width="20" align="absmiddle">' }
  end

  context ':ru_shalm: is my avatar' do
    let(:text) { ':ru_shalm: is my avatar' }
    it { should eq '<img class="emoji" title=":ru_shalm:" alt=":ru_shalm:" src="http://toripota.com/img/ru_shalm.png" height="20" width="20" align="absmiddle"> is my avatar' }
  end
end
