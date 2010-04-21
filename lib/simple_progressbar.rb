class SimpleProgressbar

  def show(title, &block)
    print title + " "
    start_progress
    instance_eval(&block)
    finish_progress
  end

  def progress(percent)
    print "\e[18D"
    render_progress(percent)
  end

  private

  def render_progress(percent)
    print "["

    (percent/10).to_i.times do 
      print "*" 
    end
    (10 - (percent/10).to_i).times do 
      print " " 
    end
    print "]\e[32m#{'%4s' % percent}\e[0m %"
    STDOUT.flush
  end

  def start_progress
    render_progress(0)
  end

  def finish_progress
    puts
  end
end