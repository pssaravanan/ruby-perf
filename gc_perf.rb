require 'benchmark'
num_rows = 100000
num_cols = 10

time = Benchmark.realtime do
  data = Array.new(num_rows) {Array.new(num_cols)  {'x' * 1000}}
  csv = data.map do |row|
    row.join(',')
  end.join('\n')
  # csv = ''
  # num_rows.times do |i|
  #   num_cols.times do |j|
  #     csv << data[i][j]
  #     csv << ',' unless j == num_cols - 1
  #   end
  #   csv << '\n' unless i == num_rows - 1
  # end
end
p `ps -o rss= -p #{Process.pid}`
p time.round(2)