require 'chronic'

class ReviewRange
  def initialize(opts)
    @start = opts[:start].push('+00:00')
    @stop  = opts[:stop].push('+00:00')

    @start_iso = Chronic.parse(Time.utc(*@start).to_s).iso8601()
    @stop_iso  = Chronic.parse(Time.utc(*@stop).to_s).iso8601()

    @increment_phrase = opts[:increment_phrase]

    @slice_begin = Chronic.parse(Time.utc(*@start).to_s)
    @slice_end   = Chronic.parse(@increment_phrase, :now => @slice_begin)
  end

  def next
    yield @slice_begin.iso8601(), @slice_end.iso8601()
    while @slice_end.iso8601() != @stop_iso
      iterate
      yield @slice_begin.iso8601(), @slice_end.iso8601()
    end
  end

  private

  def iterate
    @slice_begin = @slice_end
    @slice_end   = Chronic.parse(@increment_phrase, :now => @slice_end)
  end

end
