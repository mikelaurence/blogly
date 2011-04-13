class DateTime

  # Backported for Ruby pre-1.9.2
  def rfc3339
    strftime('%Y-%m-%dT%H:%M:%S%z')
  end

end