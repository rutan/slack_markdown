# encoding: utf-8
require 'spec_helper'

describe SlackMarkdown::Filters::MultipleCodeFilter do
  subject do
    filter = SlackMarkdown::Filters::MultipleCodeFilter.new(text)
    filter.call.to_s
  end

  context 'multiple code' do
    let(:text) { "```\ndef hoge\n  1 + 1\nend\n```" }
    it { should eq "<pre><code>def hoge\n  1 + 1\nend\n</code></pre>" }
  end
end
