# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::EmojiFilter do
  subject do
    context = {
      asset_root: '/assets',
      original_emoji_set: {
        'ru_shalm' => 'http://toripota.com/img/ru_shalm.png',
        'shalm' => 'alias:ru_shalm',
        'happy' => 'alias:smile'
      }
    }
    filter = SlackMarkdown::Filters::EmojiFilter.new(text, context)
    filter.call.to_s
  end

  context 'Hello :smile:' do
    let(:text) { 'Hello :smile:' }
    it {
      should eq 'Hello <img class="emoji" title=":smile:" alt=":smile:" src="/assets/emoji/unicode/1f604.png" height="20" width="20" align="absmiddle">'
    }
  end

  context ':ru_shalm: is my avatar' do
    let(:text) { ':ru_shalm: is my avatar' }
    it {
      should eq '<img class="emoji" title=":ru_shalm:" alt=":ru_shalm:" src="http://toripota.com/img/ru_shalm.png" height="20" width="20" align="absmiddle"> is my avatar'
    }
  end

  context ':shalm: is an emoji alias' do
    let(:text) { ':shalm: is an emoji alias' }
    it {
      should eq '<img class="emoji" title=":shalm:" alt=":shalm:" src="http://toripota.com/img/ru_shalm.png" height="20" width="20" align="absmiddle"> is an emoji alias'
    }
  end

  context ':happy: is aliased to a standard unicode emoji' do
    let(:text) { ':happy: is aliased to a standard unicode emoji' }
    it {
      should eq '<img class="emoji" title=":happy:" alt=":happy:" src="/assets/emoji/unicode/1f604.png" height="20" width="20" align="absmiddle"> is aliased to a standard unicode emoji'
    }
  end
end
