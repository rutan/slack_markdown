# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::MultipleQuoteFilter do
  subject do
    filter = SlackMarkdown::Filters::MultipleQuoteFilter.new(text)
    filter.call.to_s
  end

  context '>>> hoge' do
    let(:text) { '&gt;&gt;&gt; hoge' }
    it { should eq '<blockquote>hoge</blockquote>' }
  end

  context 'multiline' do
    let(:text) { "&gt;&gt;&gt;\nhoge\nfuga" }
    it { should eq "<blockquote>hoge\nfuga</blockquote>" }
  end
end
