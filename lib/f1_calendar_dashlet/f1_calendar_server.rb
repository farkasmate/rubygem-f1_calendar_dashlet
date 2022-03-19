# frozen_string_literal: true

require 'dashlet/server'

module Dashlet
  # Dashlet returning date and time of next F1 calendar events
  class F1CalendarServer < Server
    get '/' do
      Template.render('hello', 'world')
    end
  end
end
