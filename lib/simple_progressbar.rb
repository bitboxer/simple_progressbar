class SimpleProgressbar

  def show(title, &block)
    print title + " "
    start_progress
    # thanks to http://www.dcmanges.com/blog/ruby-dsls-instance-eval-with-delegation
    @self_before_instance_eval = eval "self", block.binding
    instance_eval(&block)
    finish_progress
  end

  def progress(percent)
    print "\e[18D"
    render_progress(percent)
  end

  def method_missing(method, *args, &block)
    @self_before_instance_eval.send method, *args, &block
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
