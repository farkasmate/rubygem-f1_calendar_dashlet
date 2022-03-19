# frozen_string_literal: true

require 'dashlet/server'
require 'icalendar'

module Dashlet
  # NOTE: https://calendar.google.com/calendar/ical/271q0upfs3pogocbdh24fvski99ajd6l%40import.calendar.google.com/public/basic.ics
  F1_CALENDAR = 'f1.ics'

  # Dashlet returning date and time of next F1 calendar events
  class F1CalendarServer < Server
    get '/' do
      cal_file = File.open(F1_CALENDAR)
      cal = Icalendar::Calendar.parse(cal_file).first

      next_event = cal.events.sort_by(&:dtstart).find { |event| event.dtstart > DateTime.now }

      Template.render(next_event.summary, next_event.dtstart)
    end
  end
end
