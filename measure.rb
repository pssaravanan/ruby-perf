require "json"
require "benchmark"
def measure(&block)
  no_gc = (ARGV[0] == "--no-gc")
  if no_gc
    GC.disable
  else
    GC.start
  end
  memory_before = `ps -o rss= -p #{Process.pid}`.to_i/1024
  gc_stat_before = GC.stat
  time = Benchmark.realtime do
    yield
  end
  gc_stat_after = GC.stat
  GC.start unless no_gc
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i/1024
  puts({ RUBY_VERSION => { gc: no_gc ? 'disabled' : 'enabled', time: time.round(2), gc_count: gc_stat_after[:count] - gc_stat_before[:count], memory: "%dM" % (memory_after - memory_before) } }.to_json) end
