# frozen_string_literal: true

require 'spec_helper'

describe SlackMarkdown::Filters::QuoteFilter do
  subject do
    filter = SlackMarkdown::Filters::QuoteFilter.new(text)
    filter.call.to_s
  end

  context '> hoge' do
    let(:text) { '&gt; hoge' }
    it { should eq "<blockquote>hoge\n</blockquote>" }
  end

  context 'multiline' do
    let(:text) { "&gt; hoge\n&gt; fuga" }
    it { should eq "<blockquote>hoge\nfuga\n</blockquote>" }
  end

  context 'include text element' do
    let(:text) { "&gt; hoge\n&gt; fuga\ntext\n&gt; hai" }
    it { should eq "<blockquote>hoge\nfuga\n</blockquote>text\n<blockquote>hai\n</blockquote>" }
  end
end
