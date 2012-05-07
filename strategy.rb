class Strategy

  private

    def report(socialmine_id, rank)
      print "##### #{socialmine_id} achieved #{rank}  #####\n"
    end

    def add_members(n)
      n.times { @user.sponsor_a_service_only }
    end

    def sponsor_users(n)
      n.times do
        user = @user.sponsor_someone
        yield(user) if block_given?
      end
    end
end
