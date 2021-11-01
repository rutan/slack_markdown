# frozen_string_literal: true

require 'html/pipeline'
require 'escape_utils'

module SlackMarkdown
  module Filters
    # https://api.slack.com/docs/formatting
    class ConvertFilter < ::HTML::Pipeline::TextFilter
      def call
        html = @text.gsub(/<([^>|]+)(?:\|([^>]+))?>/) do |_match|
          link_data = Regexp.last_match(1)
          link_text = Regexp.last_match(2)
          create_link(link_data, link_text)
        end
        Nokogiri::HTML.fragment(html)
      end

      private

      def create_link(data, override_text = nil)
        klass, link, text =
          case data
          when /\A#(C.+)\z/ # channel
            channel = context.include?(:on_slack_channel_id) ? context[:on_slack_channel_id].call(Regexp.last_match(1)) : nil
            if channel
              override_text = nil
              ['channel', channel[:url], "##{channel[:text]}"]
            else
              ['channel', data, data]
            end
          when /\A@((?:U|B).+)/ # user or bot
            user = context.include?(:on_slack_user_id) ? context[:on_slack_user_id].call(Regexp.last_match(1)) : nil
            if user
              override_text = nil
              ['mention', user[:url], "@#{user[:text]}"]
            else
              ['mention', nil, data]
            end
          when /\A@(.+)/ # user name
            user = context.include?(:on_slack_user_name) ? context[:on_slack_user_name].call(Regexp.last_match(1)) : nil
            if user
              override_text = nil
              ['mention', user[:url], "@#{user[:text]}"]
            else
              ['mention', nil, data]
            end
          when /\A!/ # special command
            ['link', nil, data]
          else # normal link
            ['link', data, data]
          end

        if link
          escaped_link =
            if context[:cushion_link] && link.match(%r{\A([A-Za-z0-9]+:)?//})
              "#{EscapeUtils.escape_html context[:cushion_link]}#{EscapeUtils.escape_url link}"
            else
              EscapeUtils.escape_html(link).to_s
            end
          "<a href=\"#{escaped_link}\" class=\"#{EscapeUtils.escape_html(klass)}\">#{EscapeUtils.escape_html(override_text || text)}</a>"
        else
          EscapeUtils.escape_html(override_text || text)
        end
      end
    end
  end
end
