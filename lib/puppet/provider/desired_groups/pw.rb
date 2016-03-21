Puppet::Type.type(:desired_groups).provide(:pw) do

    desc "Manage user's groups via pw"

    confine :kernel => [ :FreeBSD ]
    defaultfor :kernel => [ :FreeBSD ]

    commands :usermod => "/usr/sbin/pw"

    # helper method
    def get_user_groups(user)
        user_groups = []
        Etc.setgrent
        Etc.group {|g|
            if g.mem.include? user
                user_groups << g.name
            end
        }
        Etc.endgrent
        user_groups
    end

    # getter
    def groups
        user = @resource[:name]
        desired_groups = @resource[:groups]
        current_groups = get_user_groups(user)
        groups = []

        # adding nil items to comply with user data
        desired_groups.each {|dg|
            if current_groups.include? dg
                groups << dg
            else
                groups << nil
            end
        }

        groups
    end

    # setter
    def groups=(values)
        user = @resource[:name]

        # need compact to remove nil items
        groups = values.compact
        params = [ 'usermod', user, '-G',groups.join(',') ]

        usermod(params)
    end

end
