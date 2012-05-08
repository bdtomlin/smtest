class Strategy

  private

    def report(socialmine_id, rank)
      print "##### #{socialmine_id} achieved #{rank}  #####\n"
    end

    def add_members(n)
      n.times { @user.sponsor_a_service_only }
    end

    def sponsor_users(n)
      threads = []
      n.times do
        user = @user.sponsor_someone
        if block_given?
          threads << Thread.new { yield(user) }
        end
      end
      threads.each { |thread| thread.join }
    end
end
