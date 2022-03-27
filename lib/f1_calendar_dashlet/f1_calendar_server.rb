# frozen_string_literal: true

require 'dashlet/server'
require 'icalendar'
require 'tzinfo'

module Dashlet
  # Dashlet returning date and time of next F1 calendar events
  class F1CalendarServer < Server
    # NOTE: https://calendar.google.com/calendar/ical/271q0upfs3pogocbdh24fvski99ajd6l%40import.calendar.google.com/public/basic.ics
    F1_CALENDAR = 'f1.ics'

    def initialize
      super
      @cal = Icalendar::Calendar.parse(File.open(F1_CALENDAR)).first
    end

    def next_event(pattern = //)
      @cal.events.select { |event| event.summary =~ pattern }.sort_by(&:dtstart).find { |event| event.dtstart > DateTime.now }
    end

    def local_time(time, timezone)
      begin
        tz = TZInfo::Timezone.get(timezone)
      rescue TZInfo::InvalidTimezoneIdentifier
        tz = TZInfo::Timezone.get('UTC')
      end

      time.getlocal(tz.observed_utc_offset)
    end

    get '/race/?' do
      event = next_event(/^.*Race$/)
      summary = event.summary
      time = local_time(event.dtstart.to_time, params[:timezone])

      Template.render(summary, time)
    end

    get '/race_or_quali/?' do
      event = next_event(/^.*(Race|Qualifying)$/)
      summary = event.summary
      time = local_time(event.dtstart.to_time, params[:timezone])

      Template.render(summary, time)
    end

    get '/' do
      event = next_event
      summary = event.summary
      time = local_time(event.dtstart.to_time, params[:timezone])

      Template.render(summary, time)
    end
  end
end
