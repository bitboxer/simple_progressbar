class SimpleProgressbar

  def show(title, &block)
    print title + " "
    start_progress
    instance_eval(&block)
    finish_progress
  end

  def set_progress(percent)
    print "\e[19D"
    render_progress(percent)
  end

  private

  def render_progress(percent)
    line = "["

    for i in 0..(percent/10).to_i
      line += "*"
    end
    for i in (percent/10).to_i..9
      line += " "
    end

    line += "]\e[32m#{'%4s' % percent}\e[0m %"
    print line
    STDOUT.flush
  end

  def start_progress
    render_progress(0)
  end

  def finish_progress
    puts
  end
end