class CacheInstrumenter < ActiveSupport::LogSubscriber
  def cache_read(event)
    return unless logger.debug?
    name = "%s (%.2fms)" % ["Cache Read", event.duration]
    debug "  #{color(name, BLUE, true)} #{event.payload[:key]} #{event.payload.except(:key)}"
  end

  def cache_write(event)
    return unless logger.debug?
    name = "%s (%.2fms)" % ["Cache Write", event.duration]
    debug "  #{color(name, BLUE, true)} #{event.payload[:key]}"
  end
end

Rails.cache.silence!
CacheInstrumenter.attach_to(:active_support)
