class Request < ApplicationRecord
  include AASM

 aasm do
    state :sleeping, :initial => true, :before_enter => :do_something
    state :running
    state :finished
    after_all_transitions :log_status_change

    event :run, :after => :notify_somebody do
      before do
        log('Preparing to run')
      end

      transitions :from => :sleeping, :to => :running, :after => :notify_somebody
      transitions :from => :running, :to => :finished, :after => :notify_somebody
    end

    event :sleep do
      after do
        puts "sleep again ..."
      end
      error do |e|
        puts "error"
      end
      transitions :from => :running, :to => :sleeping
    end
  end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end


  def do_something
    puts "triggered #{aasm.current_event}"
  end

  def notify_somebody
    puts "notice!!"
  end

end