class HardWorkers
  include Sidekiq::Worker

  def perform(answer, u_a)
    puts ' * * * * * * * * * * * * * * * * * * '
    puts answer
    puts u_a
    puts ' * * * * * * * * * * * * * * * * * * '

  end
end