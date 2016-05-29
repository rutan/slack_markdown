# encoding: utf-8

require 'html/pipeline'

module SlackMarkdown
  module Filters
    class EmojiFilter < ::HTML::Pipeline::EmojiFilter
      def emoji_url(name)
        emoji_names.include?(name) ? super : original_emoji_path(name)
      end

      def emoji_pattern
        @emoji_pattern ||= /:(#{(emoji_names + original_emoji_names).map { |name| Regexp.escape(name) }.join('|')}):/
      end

      def emoji_names
        self.class.superclass.emoji_names
      end

      def original_emoji_set
        context[:original_emoji_set] || {}
      end

      def original_emoji_names
        original_emoji_set.keys
      end

      def original_emoji_path(name)
        original_emoji_set[name]
      end
    end
  end
end
