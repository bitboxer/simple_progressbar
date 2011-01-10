class SimpleProgressbar
  def initialize
    @last_length = 0
  end

  def show(title, &block)
    print title + " "
    start_progress
    # thanks to http://www.dcmanges.com/blog/ruby-dsls-instance-eval-with-delegation
    @self_before_instance_eval = eval "self", block.binding
    instance_eval(&block)
    finish_progress
  end

  def progress(percent)
    print "\e[#{15 + @last_length}D"
    render_progress(percent)
  end

  def method_missing(method, *args, &block)
    @self_before_instance_eval.send method, *args, &block
  end

  private

  def render_progress(percent)
    print "["

    print "*" * [(percent/10).to_i, 10].min
    print " " * [10 - (percent/10).to_i, 0].max

    if percent.class != Float
      printable_percent = "%3s" % percent
    else
      non_decimal_digits = (Math.log(percent) / Math.log(10)).truncate + 1
      printable_percent = (non_decimal_digits < 3 ? " " * (3 - non_decimal_digits) : "") + percent.to_s
    end

    print "]\e[32m #{printable_percent}\e[0m %"

    new_length = printable_percent.length
    if @last_length > new_length
      print " " * (@last_length - new_length)
      print "\e[#{@last_length - new_length}D"
    end
    @last_length = new_length

    STDOUT.flush
  end

  def start_progress
    render_progress(0)
  end

  def finish_progress
    puts
  end
end
